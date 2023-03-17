import CoreData
public struct SymbolGraphUMLParser {
    
    var graph = Graph()
    
    var factory = SymbolFactory()
    
    var textDiagramParser = MermaidParser()

    var curator = Curation()
    
    
    public mutating func parse(
        name: String,
        kind: String,
        rawTypes: [[String: String]] = [],
        parentName: String? = nil,
        parentSymbolKind: String? = nil,
        relationType: String? = nil,
        accessLevel: String? = nil,
        parameters: [String]? = nil,
        returns: [String]? = nil
    ) {
        
//        print("symbol name: \(name) \n and kind: \(kind) \n with access: \(accessLevel) \n with parent: \(parentName) of relation type: \(relationType) \n function with parameters: \(parameters) -> \(returns)")
        
        var curatedRawTypes : [[String: String]] = []
        for (idx, type) in rawTypes.enumerated() {
            if (type["kind"] == "typeIdentifier") {
                curatedRawTypes.append(rawTypes[idx - 1])
                curatedRawTypes.append(rawTypes[idx])
                if (idx != rawTypes.endIndex - 1) {
                    curatedRawTypes.append(rawTypes[idx + 1])
                }
            }
            if (type["kind"] == "genericParameter") {
                curatedRawTypes.append(type)
            }
        }
        

        factory.createSymbol(
            name: name,
            kind: kind,
            rawTypes: curatedRawTypes,
            accessLevel: accessLevel,
            parentSymbolName: parentName,
            parentSymbolKind: parentSymbolKind,
            relationType: relationType,
            parameters: parameters,
            returns: returns,
            graph: &graph
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
    
    public mutating func getTextDiagram() {
        print("textDiagramParser.parse(entities: graph.entities)")
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
    }

    public init() {
    }
}
