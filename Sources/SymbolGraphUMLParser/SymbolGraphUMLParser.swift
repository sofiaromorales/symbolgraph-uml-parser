import CoreData
public struct SymbolGraphUMLParser {
    
    var entities: [String : Entity] = [:]
    var properties: [String: Property] = [:]
    var methods: [String: Method] = [:]

    
    mutating func createSymbol(
        name: String,
        kind: String,
        type: String?,
        accessLevel: String?,
        parentSymbolName: String?,
        parentSymbolKind: String?,
        relationType: String?,
        parameters: [String]?,
        returns: [String]?
    ) {

        // If symbol is an entity check if exists and return
        if EntityKinds.entityKinds.contains(kind) {
            if entities[name] == nil {
                entities[name] = Entity(name: name, kind: kind)
            }
            // Add entity relationships
            guard
                let parentSymbolName = parentSymbolName,
                let parentSymbolKind = parentSymbolKind,
                let relationType = relationType,
                let relationKind = RelationKinds(rawValue: relationType)
            else {
                return
            }
            if entities[parentSymbolName] == nil {
                entities[parentSymbolName] = Entity(name: parentSymbolName, kind: parentSymbolKind)
            }
            if entities[name]!.relations[relationKind] == nil {
                entities[name]!.relations[relationKind] = []
            }
            var parentEntity = entities[parentSymbolName]!
            entities[name]!.relations[relationKind]?.append(parentEntity)
            return
        }
        
        // If symbol is a property create it and assign it to the expected entity
        if PropertyKinds.propertyKinds.contains(kind) && properties[name] == nil {
            properties[name] = Property(
                accessLevel: AccessLevelKinds(rawValue: accessLevel ?? "none") ?? .none,
                name: name,
                type: type ?? "undefined",
                kind: PropertyKinds(rawValue: kind) ?? .none
            )
        }
        
        // If a symbol is a method create it and assign it to the expected entity
        if kind == SymbolType.method.rawValue && methods[name] == nil {
            methods[name] = Method(
                name: name,
                kind: kind,
                parameters: parameters ?? [],
                returns: returns ?? []
            )
        }
        
        guard let parentSymbolName = parentSymbolName, let relationType = relationType else {
            return
        }
        
        if (PropertyKinds.existingRelations.contains(relationType)) {
            if (PropertyKinds.propertyKinds.contains(kind)) {
                entities[parentSymbolName]?.properties[name] = properties[name]
            }
            else if (kind == SymbolType.method.rawValue) {
                entities[parentSymbolName]?.methods[name] = methods[name]
            }
        }
        
    }
    
    public mutating func parse(
        name: String,
        kind: String,
        rawType: [String] = [],
        parentName: String? = nil,
        parentSymbolKind: String? = nil,
        relationType: String? = nil,
        accessLevel: String? = nil,
        parameters: [String]? = nil,
        returns: [String]? = nil
    ) {
        print("symbol name: \(name) \n of type \(rawType) and kind: \(kind) \n with access: \(accessLevel) \n with parent: \(parentName) of relation type: \(relationType) \n function with parameters: \(parameters) -> \(returns)")
        
        
        var type = [PropertyType]()
        for (idx, fragment) in rawType.enumerated() {
            if fragment.kind == "typeIdentifier" {
                
            }
        }
        
        createSymbol(
            name: name,
            kind: kind,
            type: rawType,
            accessLevel: accessLevel,
            parentSymbolName: parentName,
            parentSymbolKind: parentSymbolKind,
            relationType: relationType,
            parameters: parameters,
            returns: returns
        )
    }
    
    public func enumerateEntitiesWithProperties() {
        for (_, entity) in entities {
            print("\n")
            print("|⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻|")
            print("| \(entity.name) - \(entity.kind) |")
            print("|--------------------------------------|")
            for (_, property) in entity.properties {
                print("| \(property.accessLevel) \(property.name) \(property.symbolType) |")
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
    
    public private(set) var text = "Hello, World!"

    public init() {
    }
}
