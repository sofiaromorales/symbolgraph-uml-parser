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
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolID: parentSymbolDTO.identifier.precise, graph: &graph)
        }
        if symbolDTO.kind.displayName == SymbolType.method.rawValue {
            if (graph.methods[symbolDTO.identifier.precise] == nil) {
                graph.methods[symbolDTO.identifier.precise] = createMethod(symbolDTO: symbolDTO)
            }
            guard let parentSymbolDTO = parentSymbolDTO, let relationType = relationType else {
                return
            }
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolID: parentSymbolDTO.identifier.precise, graph: &graph)
        }
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
        if (PropertyKinds.existingRelations.contains(relationType)) {
            guard let _ = graph.entities[parentSymbolID] else {
                print("assignRelationship")
                exit(1)
            }
            if (PropertyKinds.propertyKinds.contains(symbolDTO.kind.displayName)) {
                graph.entities[parentSymbolID]?.properties[symbolDTO.identifier.precise] = graph.properties[symbolDTO.identifier.precise]
            }
            else if (symbolDTO.kind.displayName == SymbolType.method.rawValue) {
                graph.entities[parentSymbolID]?.methods[symbolDTO.identifier.precise] = graph.methods[symbolDTO.identifier.precise]
            }
        }
    }
    
    func addEntityToEntityRelation(relationType: String?, graph: inout SymbolGraphModel, symbolDTO: SymbolDTO, parentSymbolDTO: SymbolDTO?) {
        guard
            let parentSymbolDTO = parentSymbolDTO,
            let relationType = relationType,
            let relationKind = RelationKinds(rawValue: relationType)
        else {
            return
        }
        if graph.entities[symbolDTO.identifier.precise] == nil {
            graph.entities[symbolDTO.identifier.precise] = createEntity(symbolDTO: parentSymbolDTO)
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
        
        return
    }
    
}
