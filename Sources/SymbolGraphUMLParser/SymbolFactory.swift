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
        graph: inout Graph,
        symbolDTO: SymbolDTO,
        parentSymbolDTO: SymbolDTO?
    ) {
        
        if EntityKinds.entityKinds.contains(symbolDTO.kind.displayName) {
            if graph.entities[symbolDTO.names.title] == nil {
                graph.entities[symbolDTO.names.title] = createEntity(symbolDTO: symbolDTO)
            }
            addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        }
        if PropertyKinds.propertyKinds.contains(symbolDTO.kind.displayName) {
            if (graph.properties[symbolDTO.names.title] == nil) {
                graph.properties[symbolDTO.names.title] = createProperty(symbolDTO: symbolDTO)
            }
            guard let parentSymbolDTO = parentSymbolDTO, let relationType = relationType else {
                return
            }
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolName: parentSymbolDTO.names.title, graph: &graph)
        }
        if symbolDTO.kind.displayName == SymbolType.method.rawValue {
            if (graph.methods[symbolDTO.names.title] == nil) {
                graph.methods[symbolDTO.names.title] = createMethod(symbolDTO: symbolDTO)
            }
            guard let parentSymbolDTO = parentSymbolDTO, let relationType = relationType else {
                return
            }
            assignRelationship(symbolDTO: symbolDTO, relationType: relationType, parentSymbolName: parentSymbolDTO.names.title, graph: &graph)
        }
    }
    
    func createEntity(
        symbolDTO: SymbolDTO
    ) -> Entity {

        var genericParameters = [SwiftGenerics.Parameter]()
        if let parameters = symbolDTO.swiftGenerics?.parameters {
            for parameter in parameters {
                genericParameters.append(SwiftGenerics.Parameter(name: parameter.name, index: parameter.index, depth: parameter.depth))
            }
        }
        
        var genericConstraints = [SwiftGenerics.Constraint]()
        if let constraints = symbolDTO.swiftGenerics?.constraints {
            for constraint in constraints {
                genericConstraints.append(SwiftGenerics.Constraint(kind: constraint.kind, rhs: constraint.rhs, lhs: constraint.lhs))
            }
        }
        
        let entity = Entity(name: symbolDTO.names.title, kind: EntityKinds(rawValue: symbolDTO.kind.displayName) ?? .other, generics: SwiftGenerics(parameters: genericParameters, constraints: genericConstraints))
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
                let propertyType = PropertyType(
                    identifier: rawTypes[idx]["spelling"] ?? "",
                    initialOperators: rawTypes[idx - 1]["spelling"] ?? "",
                    finalOperators: idx + 1 != rawTypes.endIndex ? rawTypes[idx + 1]["spelling"] ?? "" : ""
                )
                propertyTypes.append(
                    propertyType
                )
            }
        }
    
        var property = Property(
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
                functionSignature = parameter.name
                for fragment in parameter.declarationFragments {
                    if fragment.kind == "typeIdentifier" {
                        functionSignature += ": \(fragment.spelling)"
                    }
                }
                functionParameters.append(functionSignature)
            }
        }
        
        var functionReturns: [String] = []
        
        if let returns = DTOfunctionSignature.returns {
            for lreturn in returns {
                functionReturns.append(
                    lreturn.spelling == "()"
                    ? lreturn.kind
                    : lreturn.spelling
                )
            }
        }
        
        var genericParameters = [SwiftGenerics.Parameter]()
        if let parameters = symbolDTO.swiftGenerics?.parameters {
            for parameter in parameters {
                genericParameters.append(SwiftGenerics.Parameter(name: parameter.name, index: parameter.index, depth: parameter.depth))
            }
        }
        
        var genericConstraints = [SwiftGenerics.Constraint]()
        if let constraints = symbolDTO.swiftGenerics?.constraints {
            for constraint in constraints {
                genericConstraints.append(SwiftGenerics.Constraint(kind: constraint.kind, rhs: constraint.rhs, lhs: constraint.lhs))
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
            generics: SwiftGenerics(parameters: genericParameters, constraints: genericConstraints)
        )
        
        return method
    }
    
    func assignRelationship(symbolDTO: SymbolDTO, relationType: String, parentSymbolName: String, graph: inout Graph) {
        if (PropertyKinds.existingRelations.contains(relationType)) {
            guard let _ = graph.entities[parentSymbolName] else {
                print("assignRelationship")
                exit(1)
            }
            if (PropertyKinds.propertyKinds.contains(symbolDTO.kind.displayName)) {
                graph.entities[parentSymbolName]?.properties[symbolDTO.names.title] = graph.properties[symbolDTO.names.title]
            }
            else if (symbolDTO.kind.displayName == SymbolType.method.rawValue) {
                graph.entities[parentSymbolName]?.methods[symbolDTO.names.title] = graph.methods[symbolDTO.names.title]
            }
        }
    }
    
    func addEntityToEntityRelation(relationType: String?, graph: inout Graph, symbolDTO: SymbolDTO, parentSymbolDTO: SymbolDTO?) {
        guard
            let parentSymbolDTO = parentSymbolDTO,
            let relationType = relationType,
            let relationKind = RelationKinds(rawValue: relationType)
        else {
            return
        }
        if graph.entities[parentSymbolDTO.names.title] == nil {
            graph.entities[parentSymbolDTO.names.title] = createEntity(symbolDTO: parentSymbolDTO)
        }
        guard let entity = graph.entities[symbolDTO.names.title] else {
            print("exit 1")
            exit(1)
        }
        guard let parentEntity = graph.entities[parentSymbolDTO.names.title] else {
            print("exit 2")
            exit(1)
        }
        if entity.relations[relationKind] == nil {
            graph.entities[symbolDTO.names.title]!.relations[relationKind] = []
        }
        
        graph.entities[symbolDTO.names.title]!.relations[relationKind]?.append(parentEntity)
        
        return
    }
    
}
