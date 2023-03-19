import CoreData
public struct SymbolGraphUMLParser {
    
    var graph = Graph()
    
    var factory = SymbolFactory()
    
    var textDiagramParser = MermaidParser()

    var curator = Curation()
    
    
    public mutating func parse(
        relationType: String? = nil,
        symbolJSON: String,
        parentSymbolJSON: String? = nil
    ) {
        
        guard symbolJSON != "null" else { return }
        
//        print("symbol name: \(name) \n and kind: \(kind) \n with access: \(accessLevel) \n with parent: \(parentName) of relation type: \(relationType) \n function with parameters: \(parameters) -> \(returns)")
        
        let symbolDTO = SymbolDTO(json: symbolJSON)
        var parentSymbolDTO: SymbolDTO? = nil
        if let parentSymbolJSON = parentSymbolJSON {
            if parentSymbolJSON != "null" {
                parentSymbolDTO = SymbolDTO(json: parentSymbolJSON)
            }
        }
    
        factory.createSymbol(
            relationType: relationType,
            graph: &graph,
            symbolDTO: symbolDTO,
            parentSymbolDTO: parentSymbolDTO
        )
    }
    
    public func enumerateEntitiesWithProperties() {
        for (_, entity) in graph.entities {
            print("\n")
            print("|⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻|")
            print("| \(entity.name) - \(entity.kind) |")
            print("|--------------------------------------|")
            for (_, property) in entity.properties {
                print("| \(property.accessLevel) \(property.name) : \(property.textType) |")
            }
            print("|---------------------------------------|")
            for (_, method) in entity.methods {
                print("| \(method.accessLevel) \(method.name) \(method.parameters) -> \(method.returns) |")
            }
            print("|---------------------------------------|")
            for (relation, entities) in entity.relations {
                for entity in entities {
                    print("| \(relation.rawValue) ---> \(entity.name) |")
                }
            }
            print("|_______________________________________|")
            print("\n")
            print("|||||")
            
        }
    }
    
    public mutating func getTextDiagram() -> String {
        for entity in graph.entities {
            if (entity.value.kind == .lclass) {
                if (entity.value.relations[.inheritsFrom] == nil && entity.value.relations[.conformsTo] == nil) {
                    continue
                }
                let parents = (entity.value.relations[.inheritsFrom] ?? []) + (entity.value.relations[.conformsTo] ?? [])
                curator.curateEntityConformanceRelation(entity: &graph.entities[entity.key]!, parentEntities: parents)
                continue
            }
        }
        print(textDiagramParser.parse(entities: Array(graph.entities.values)))
        return textDiagramParser.parse(entities: Array(graph.entities.values))
    }

    public init() {
    }
}
