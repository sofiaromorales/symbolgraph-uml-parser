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
//        symbolsDTORelationship.sort {
//            $0.2?.kind.displayName ?? "none" < $1.2?.kind.displayName ?? "none" && $0.0.kind.displayName < $1.0.kind.displayName
//        }
//        symbolsDTORelationship.sort {
//            switch ($0, $1) {
//            case ((_, nil, _), (_, .some($1.relation), _)):
//                    return true
//                case ((_, .some($0.relation), _), (_, nil, _)):
//                    return false
//                case ((_, nil, _), (_, nil, _)):
//                    return true
//            case ((_, .some($0.relation), _), (_, .some($1.relation), _)):
//                print("$0.relation")
//                print($0.relation)
//                print($0.parentSymbolDTO)
//                guard let parentSymbolDTO = $0.parentSymbolDTO else { return false }
//                if parentSymbolDTO.kind.displayName == "Entity" || parentSymbolDTO.kind.displayName == "Protocol" {
//                        return true
//                    }
//                    return false
//                case ((_, _, _), (_, _, _)):
//                    return false
//            }
//        }
        
        symbolsDTORelationship.sort {
            guard let firstRelation = $0.relation else { return true }
            guard let secondRelation = $1.relation else { return false }
            if (RelationKinds.extensionRelationships.contains(firstRelation) && !RelationKinds.extensionRelationships.contains(secondRelation)) { return false }
            if (!RelationKinds.extensionRelationships.contains(firstRelation) && RelationKinds.extensionRelationships.contains(secondRelation)) { return true }
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
            if (entity.value.kind == .lclass) {
                if (entity.value.relations[.inheritsFrom] == nil && entity.value.relations[.conformsTo] == nil) {
                    continue
                }
                let parentRelations = (entity.value.relations[.inheritsFrom] ?? []) + (entity.value.relations[.conformsTo] ?? [])
                curator.curateEntityConformanceRelation(entity: &graph.entities[entity.key]!, parentEntities: parentRelations.map { $0.0 })
                continue
            }
        }
        // curator.transformToExplicitAssociationDiagram(graph: &graph)
        // print(textDiagramParser.parse(entities: Array(graph.entities.values)))
        _ = enumerateEntitiesWithProperties(graph)
        return textDiagramParser.parse(entities: Array(graph.entities.values))
    }

    public init() {
    }
}
