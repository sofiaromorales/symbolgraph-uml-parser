import CoreData
public struct SymbolGraphUMLParser {
    
    var graph = SymbolGraphModel()
    
    var factory = SymbolFactory()
    
    var textDiagramParser: TextUMLClassParser = MermaidParser()

    var curator = Curation()
    
    var symbolsDTORelationship: [(symbolDTO: SymbolDTO, relation: String?, parentSymbolDTO: SymbolDTO?)] = []
    
    
    public mutating func parse(
        relationType: String? = nil,
        symbolJSON: String,
        parentSymbolJSON: String? = nil
    ) {
        
        var relation = relationType
        
        guard symbolJSON != "null" else { return }
        
        let symbolDTO = SymbolDTO(json: symbolJSON)
        var parentSymbolDTO: SymbolDTO? = nil
        if let parentSymbolJSON = parentSymbolJSON {
            if parentSymbolJSON != "null" {
                parentSymbolDTO = SymbolDTO(json: parentSymbolJSON)
            }
        }
        
        if (symbolDTO.kind.displayName == "Protocol" && parentSymbolDTO?.kind.displayName == "Protocol") {
            relation = "inheritsFrom"
        }
    
//        factory.createSymbol(
//            relationType: relation,
//            graph: &graph,
//            symbolDTO: symbolDTO,
//            parentSymbolDTO: parentSymbolDTO
//        )
        
        symbolsDTORelationship.append((symbolDTO: symbolDTO, relation: relation, parentSymbolDTO: parentSymbolDTO))
    }
    
    func enumerateEntitiesWithProperties(_ graph: SymbolGraphModel) -> String {
        // curator.transformToExplicitAssociationDiagram(graph: &graph)
        var diagram = ""
        let sortedEntities = graph.entities.sorted(by: { $0.0 < $1.0 })
        for (_, entity) in sortedEntities {
            diagram.append("""
            |⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻|
            | \(entity.name) - \(entity.kind) |
            |--------------------------------------|\n
            """)
            let sortedProperties = entity.properties.sorted(by: { $0.0 < $1.0 })
            for (_, property) in sortedProperties {
                diagram.append("| \(property.accessLevel) \(property.name) : \(property.literalTextType) |\n")
            }
            diagram.append("|---------------------------------------|\n")
            let sortedMethods = entity.methods.sorted(by: { $0.0 < $1.0 })
            for (id, method) in sortedMethods {
                diagram.append("| \(method.accessLevel) \(method.name) \(method.parameters) -> \(method.returns) (\(id))|\n")
            }
            diagram.append("|---------------------------------------|\n")
            let sortedRelations = entity.relations.sorted(by: { $0.0.rawValue < $1.0.rawValue })
            for (relation, entitiesRelations) in sortedRelations {
                for (entity, _) in entitiesRelations {
                    diagram.append("| \(relation.rawValue) ---> \(entity.name) |\n")
                }
            }
            diagram.append("|_______________________________________|\n***\n")

        }
        print(diagram)
        return diagram
    }
    
    public mutating func getTextDiagram() -> String {

        if symbolsDTORelationship.isEmpty { return "" }
        
        symbolsDTORelationship.sort {
            guard let firstParent =  $0.parentSymbolDTO else { return true }
            guard let secondParent = $1.parentSymbolDTO else { return false }
            if (EntityKinds.entityKinds.contains(firstParent.kind.displayName)) { return true }
            if (EntityKinds.entityKinds.contains(secondParent.kind.displayName)) { return false }
            return false
        }
        
        for relationship in symbolsDTORelationship {
            factory.createSymbol(
                relationType: relationship.1,
                graph: &graph,
                symbolDTO: relationship.0,
                parentSymbolDTO: relationship.2
            )
        }
        
        curator.transformToExplicitAssociationDiagram(graph: &graph)
        for entity in graph.entities {
         //   if (entity.value.kind == .lclass) {
                if (entity.value.relations[.inheritsFrom] == nil && entity.value.relations[.conformsTo] == nil) {
                    continue
                }
                let parentRelations = (entity.value.relations[.inheritsFrom] ?? []) + (entity.value.relations[.conformsTo] ?? [])
                curator.curateEntityConformanceRelation(entity: &graph.entities[entity.key]!, parentEntities: parentRelations.map { $0.0 })
                continue
         //   }
        }
        // curator.transformToExplicitAssociationDiagram(graph: &graph)
        // print(textDiagramParser.parse(entities: Array(graph.entities.values)))
        _ = enumerateEntitiesWithProperties(graph)
        return textDiagramParser.parse(entities: Array(graph.entities.values))
    }

    public init() {
    }
}
