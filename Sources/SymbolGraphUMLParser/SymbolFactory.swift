//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 15/3/23.
//

import Foundation

struct SymbolFactory {
    
    func createSymbol (
        relationType: String?,
        graph: inout SymbolGraphModel,
        symbolDTO: SymbolDTO,
        parentSymbolDTO: SymbolDTO?
    ) {
        if (symbolDTO.identifier.precise.contains("SYNTHESIZED")) { return }
        if EntityKinds.entityKinds.contains(symbolDTO.kind.displayName) {
            if graph.entities[symbolDTO.identifier.precise] == nil {
                graph.entities[symbolDTO.identifier.precise] = createEntity(symbolDTO: symbolDTO)
            }
            addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        }
        if PropertyKinds.propertyKinds.contains(symbolDTO.kind.displayName) {
            if (graph.properties[symbolDTO.identifier.precise] == nil) {
                graph.properties[symbolDTO.identifier.precise] = createProperty(symbolDTO: symbolDTO)
            }
            guard let parentSymbolDTO = parentSymbolDTO, let relationType = relationType else {
                return
            }
            if (
                graph.entities[parentSymbolDTO.identifier.precise] == nil && (
                    graph.properties[parentSymbolDTO.identifier.precise] != nil ||
                    graph.methods[parentSymbolDTO.identifier.precise] != nil
                )
            ) {
                resolveExtensionRelation(symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO, graph: &graph, property: graph.properties[symbolDTO.identifier.precise], method: nil)
                return
            }
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolID: parentSymbolDTO.identifier.precise, graph: &graph)
        }
        if symbolDTO.kind.displayName == SymbolType.method.rawValue {
            if (graph.methods[symbolDTO.identifier.precise] == nil) {
                graph.methods[symbolDTO.identifier.precise] = createMethod(symbolDTO: symbolDTO)
            }
            guard let parentSymbolDTO = parentSymbolDTO, let relationType = relationType else {
                return
            }
            // Check for protocol extension lieu method
            if (parentSymbolDTO.kind.displayName == EntityKinds.lprotocol.rawValue) {
                if let _ = symbolDTO.swiftExtension {
                    resolveExtensionAddOn(symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO, graph: &graph, method: graph.methods[symbolDTO.identifier.precise], property: nil)
                    return
                }
            }
            
            // Check for protocol extension default implementation
            if (
                graph.entities[parentSymbolDTO.identifier.precise] == nil && (
                    graph.properties[parentSymbolDTO.identifier.precise] != nil ||
                    graph.methods[parentSymbolDTO.identifier.precise] != nil
                )
            ) {
                resolveExtensionRelation(symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO, graph: &graph, property: nil, method: graph.methods[symbolDTO.identifier.precise])
                return
            }
            guard graph.entities[parentSymbolDTO.identifier.precise] != nil else { return }
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolID: parentSymbolDTO.identifier.precise, graph: &graph)
        }
    }
    
    func resolveExtensionAddOn(
        symbolDTO: SymbolDTO,
        parentSymbolDTO: SymbolDTO,
        graph: inout SymbolGraphModel,
        method: Method?,
        property: Property?
    ) {
        // 1. Check if extension entity already exists
        let extensionEntityID = parentSymbolDTO.identifier.precise + "EXTENSION"
        if (graph.entities[extensionEntityID] == nil) {
            // 2. If extension entity doesent exists create it
            graph.entities[extensionEntityID] = Entity(name: ":\(parentSymbolDTO.names.title)", kind: .lextension, generics: SwiftGenericDTO(parameters: [], constraints: []))
    
        }
        guard let extensionEntity = graph.entities[extensionEntityID] else {
            exit(4)
        }
        // 3. Create method/property and add it to the new extension
        if let method = method {
            graph.entities[extensionEntityID]?.methods[symbolDTO.identifier.precise] = method
        }
        else if let property = property {
            graph.entities[extensionEntityID]?.properties[symbolDTO.identifier.precise] = property
        }
        // 4. Check parent protocol. If it doesen't exists create it
        var parentProtocol: Entity?
        parentProtocol = graph.entities[parentSymbolDTO.identifier.precise]
        if parentProtocol == nil {
            // Create parent
        }
        guard let parentProtocol = parentProtocol else { exit(5) }
        // 5. Assign relationship betwen protocol and extension
        if (parentProtocol.relations[.extensionTo] == nil) {
            parentProtocol.relations[.extensionTo] = []
        }
        if (parentProtocol.relations[.extensionTo]!.contains {
            $0.0.name == graph.entities[extensionEntityID]?.name
        }) { return }
        parentProtocol.relations[.extensionTo]?.append((extensionEntity, nil))
    }
    
    func resolveExtensionRelation(
        symbolDTO: SymbolDTO,
        parentSymbolDTO: SymbolDTO,
        graph: inout SymbolGraphModel,
        property: Property?,
        method: Method?
    ) {
        var extendedEntity: Entity?
        var extendedEntityID: String?
        // 1. Get entity containing parent symbol
        for (id, entity) in graph.entities {
            
            if parentSymbolDTO.kind.displayName == SymbolType.method.rawValue && entity.methods.contains(where: { $0.key == parentSymbolDTO.identifier.precise }) {
                extendedEntity = entity
                extendedEntityID = id
            }
            if PropertyKinds.propertyKinds.contains(parentSymbolDTO.kind.displayName) && entity.properties.contains(where: { $0.key == parentSymbolDTO.identifier.precise }) {
                extendedEntity = entity
                extendedEntityID = id
            }
        }
        guard let extendedEntity = extendedEntity, let extendedEntityID = extendedEntityID else {
            print("exit 3")
            exit(3)
            // return
        }
        if (extendedEntity.relations[.extensionTo] == nil) {
            extendedEntity.relations[.extensionTo] = []
        }
        let extensionEntityName = extendedEntityID + "EXTENSION"
        // 2. Create new entity with the same name as parent symbol entity but different id and profile with <<extension>>
        if graph.entities[extensionEntityName] == nil {
            graph.entities[extensionEntityName] = Entity(name: ":\(extendedEntity.name)", kind: .lextension, generics: SwiftGenericDTO(parameters: [], constraints: []))
        }
        // 3. create property/method for the extension
        if property != nil {
            graph.entities[extensionEntityName]?.properties[symbolDTO.identifier.precise] = property
        }
        if method != nil {
            graph.entities[extensionEntityName]?.methods[symbolDTO.identifier.precise] = method
        }
        guard let extensionEntity = graph.entities[extensionEntityName] else { exit(4) }
        // 4. Create extension relationship
        if (extendedEntity.relations[.extensionTo]!.contains {
            $0.0.name == extensionEntity.name
        }) { return }
        extendedEntity.relations[.extensionTo]?.append((extensionEntity, nil))
        
    }
    
    func createEntity(
        symbolDTO: SymbolDTO
    ) -> Entity {
        var genericParameters = [SwiftGenericDTO.Parameter]()
        if let parameters = symbolDTO.swiftGenerics?.parameters {
            for parameter in parameters {
                genericParameters.append(SwiftGenericDTO.Parameter(name: parameter.name, index: parameter.index, depth: parameter.depth))
            }
        }
        
        var genericConstraints = [SwiftGenericDTO.Constraint]()
        if let constraints = symbolDTO.swiftGenerics?.constraints {
            for constraint in constraints {
                genericConstraints.append(SwiftGenericDTO.Constraint(kind: constraint.kind, rhs: constraint.rhs, lhs: constraint.lhs))
            }
        }
        let entity = Entity(name: symbolDTO.names.title, kind: EntityKinds(rawValue: symbolDTO.kind.displayName) ?? .other, generics: SwiftGenericDTO(parameters: genericParameters, constraints: genericConstraints))
        return entity
    }
    
    func createProperty(
        symbolDTO: SymbolDTO
    ) -> Property {
        var propertyTypes: [PropertyType] = []
        var rawTypes: [[String: String]] = []
        
        for fragment in symbolDTO.declarationFragments {
            rawTypes.append(["kind": "\(fragment.kind)", "spelling": "\(fragment.spelling)"])
        }
        for (idx, _) in rawTypes.enumerated() {
            if (rawTypes[idx]["kind"] == "typeIdentifier") {
                var finalOperators = idx + 1 != rawTypes.endIndex ? rawTypes[idx + 1]["spelling"] ?? "" : ""
                // Set read only property
                finalOperators = finalOperators == " { get }" ? "[readOnly]" : finalOperators
                findGet: for type in rawTypes {
                    if (type["kind"] == "keyword" && type["spelling"] == "get" && finalOperators != "[readOnly]") {
                        for innerType in rawTypes {
                            // If it's get set then is not read only
                            if (innerType["kind"] == "keyword" && innerType["spelling"] == "set") { break findGet }
                        }
                        finalOperators.append("[readOnly]")
                    }
                }
                // Remove { } characters
                let removeCharacters: Set<Character> = ["{", "}"]
                finalOperators.removeAll(where: { removeCharacters.contains($0) } )
                // Create property
                let propertyType = PropertyType(
                    identifier: rawTypes[idx]["spelling"] ?? "",
                    initialOperators: rawTypes[idx - 1]["spelling"] ?? "",
                    finalOperators: finalOperators
                )
                propertyTypes.append(
                    propertyType
                )
            }
        }
        let property = Property(
            accessLevel: AccessLevelKinds(rawValue: symbolDTO.accessLevel ) ?? .none,
            name: symbolDTO.names.title,
            types: propertyTypes,
            kind: PropertyKinds(rawValue: symbolDTO.kind.displayName) ?? .none
        )
        property.sanitizeProperties()
        return property
    }
    
    func createMethod(
        symbolDTO: SymbolDTO
    ) -> Method {
        var functionParameters: [String] = []
        var functionSignature: String = ""
        guard let DTOfunctionSignature = symbolDTO.functionSignature else { exit(1) }
        
        if let parameters = DTOfunctionSignature.parameters {
            for parameter in parameters {
                // functionSignature = parameter.name
                functionSignature = ""
                for fragment in parameter.declarationFragments {
                    if (fragment.kind == "internalParam") { continue }
                    functionSignature += fragment.spelling
//                    if fragment.kind == "typeIdentifier" {
//                        functionSignature += ": \(fragment.spelling)"
//                    }
                }
                functionParameters.append(functionSignature)
            }
        }
        
        var functionReturns: [String] = []
        
        if let returns = DTOfunctionSignature.returns {
            for lreturn in returns {
                functionReturns.append(
                    lreturn.spelling == "()"
                    ? "Void"
                    : lreturn.spelling
                )
            }
        }
        
        var genericParameters = [SwiftGenericDTO.Parameter]()
        if let parameters = symbolDTO.swiftGenerics?.parameters {
            for parameter in parameters {
                genericParameters.append(SwiftGenericDTO.Parameter(name: parameter.name, index: parameter.index, depth: parameter.depth))
            }
        }
        
        var genericConstraints = [SwiftGenericDTO.Constraint]()
        if let constraints = symbolDTO.swiftGenerics?.constraints {
            for constraint in constraints {
                genericConstraints.append(SwiftGenericDTO.Constraint(kind: constraint.kind, rhs: constraint.rhs, lhs: constraint.lhs))
            }
        }
        
        let parameterIdx = symbolDTO.names.title.firstIndex(of: "(") ?? symbolDTO.names.title.endIndex
        
        let method = Method(
            accessLevel: .lpublic,
            type: .method,
            name: String(symbolDTO.names.title[..<parameterIdx]),
            kind: symbolDTO.kind.displayName,
            parameters: functionParameters,
            returns: functionReturns,
            generics: SwiftGenericDTO(parameters: genericParameters, constraints: genericConstraints)
        )
        return method
    }
    
    func assignRelationship(symbolDTO: SymbolDTO, relationType: String, parentSymbolID: String, graph: inout SymbolGraphModel) {
            guard let _ = graph.entities[parentSymbolID] else {
                print("exit 0")
                exit(1)
            }
            if (PropertyKinds.propertyKinds.contains(symbolDTO.kind.displayName)) {
                graph.entities[parentSymbolID]?.properties[symbolDTO.identifier.precise] = graph.properties[symbolDTO.identifier.precise]
            }
            else if (symbolDTO.kind.displayName == SymbolType.method.rawValue) {
                graph.entities[parentSymbolID]?.methods[symbolDTO.identifier.precise] = graph.methods[symbolDTO.identifier.precise]
            }
        
    }
    
    @discardableResult func addEntityToEntityRelation(relationType: String?, graph: inout SymbolGraphModel, symbolDTO: SymbolDTO, parentSymbolDTO: SymbolDTO?) -> [(Entity, String?)]? {
        guard
            let parentSymbolDTO = parentSymbolDTO,
            let relationType = relationType,
            let relationKind = RelationKinds(rawValue: relationType)
        else {
            return nil
        }
//        if graph.entities[symbolDTO.identifier.precise] == nil {
//            graph.entities[symbolDTO.identifier.precise] = createEntity(symbolDTO: parentSymbolDTO)
//        }
        if graph.entities[parentSymbolDTO.identifier.precise] == nil {
            graph.entities[parentSymbolDTO.identifier.precise] = createEntity(symbolDTO: parentSymbolDTO)
        }
        guard let entity = graph.entities[symbolDTO.identifier.precise] else {
            print("exit 1")
            exit(1)
        }
        guard let parentEntity = graph.entities[parentSymbolDTO.identifier.precise] else {
            print("exit 2")
            exit(1)
        }
        if entity.relations[relationKind] == nil {
            graph.entities[symbolDTO.identifier.precise]!.relations[relationKind] = []
        }
        
        graph.entities[symbolDTO.identifier.precise]!.relations[relationKind]?.append((parentEntity, nil))
        
        return graph.entities[symbolDTO.identifier.precise]!.relations[relationKind]
    }
    
}
