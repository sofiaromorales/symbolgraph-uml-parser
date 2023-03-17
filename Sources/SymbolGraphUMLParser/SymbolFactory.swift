//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 15/3/23.
//

import Foundation

struct SymbolFactory {
    
    func createSymbol(
        name: String,
        kind: String,
        rawTypes: [[String:String]] = [],
        accessLevel: String?,
        parentSymbolName: String?,
        parentSymbolKind: String?,
        relationType: String?,
        parameters: [String]?,
        returns: [String]?,
        generics: SwiftGenerics?,
        graph: inout Graph
    ) {
        
        if EntityKinds.entityKinds.contains(kind) {
            if graph.entities[name] == nil {
                graph.entities[name] = createEntity(name: name, kind: kind, generics: generics)
            }
            addEntityToEntityRelation(name: name, parentSymbolName: parentSymbolName, parentSymbolKind: parentSymbolKind, relationType: relationType, graph: &graph)
        }
        if PropertyKinds.propertyKinds.contains(kind) {
            if (graph.properties[name] == nil) {
                graph.properties[name] = createProperty(name: name, kind: kind, parentSymbolName: parentSymbolName, parentSymbolKind: parentSymbolKind, relationType: relationType, accessLevel: accessLevel ?? "public", rawTypes: rawTypes)
            }
            guard let parentSymbolName = parentSymbolName, let relationType = relationType else {
                return
            }
            assignRelationship(relationType: relationType, kind: kind, name: name, parentSymbolName: parentSymbolName, graph: &graph)
        }
        if kind == SymbolType.method.rawValue {
            if (graph.methods[name] == nil) {
                graph.methods[name] = createMethod(name: name, kind: kind, parentSymbolName: parentSymbolName, parentSymbolKind: parentSymbolKind, relationType: relationType, parameters: parameters, returns: returns)
            }
            guard let parentSymbolName = parentSymbolName, let relationType = relationType else {
                return
            }
            assignRelationship(relationType: relationType, kind: kind, name: name, parentSymbolName: parentSymbolName, graph: &graph)
        }
    }
    
    func createEntity(
        name: String,
        kind: String,
        generics: SwiftGenerics? = nil
    ) -> Entity {
        return Entity(name: name, kind: EntityKinds(rawValue: kind) ?? .other, generics: generics)
    }
    
    func createProperty(
        name: String,
        kind: String,
        parentSymbolName: String?,
        parentSymbolKind: String?,
        relationType: String?,
        accessLevel: String,
        rawTypes: [[String:String]] = []
    ) -> Property {
        var propertyTypes: [PropertyType] = []
        
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
            accessLevel: AccessLevelKinds(rawValue: accessLevel ) ?? .none,
            name: name,
            types: propertyTypes,
            kind: PropertyKinds(rawValue: kind) ?? .none
        )
        property.sanitizeProperties()
        return property
    }
    
    func createMethod(
        name: String,
        kind: String,
        parentSymbolName: String?,
        parentSymbolKind: String?,
        relationType: String?,
        parameters: [String]?,
        returns: [String]?
    ) -> Method {
        let method = Method(
            name: name,
            kind: kind,
            parameters: parameters ?? [],
            returns: returns ?? []
        )
        
        return method
    }
    
    func assignRelationship(relationType: String, kind: String, name: String, parentSymbolName: String, graph: inout Graph) {
        if (PropertyKinds.existingRelations.contains(relationType)) {
            guard let _ = graph.entities[parentSymbolName] else {
                exit(1)
            }
            if (PropertyKinds.propertyKinds.contains(kind)) {
                graph.entities[parentSymbolName]?.properties[name] = graph.properties[name]
            }
            else if (kind == SymbolType.method.rawValue) {
                graph.entities[parentSymbolName]?.methods[name] = graph.methods[name]
            }
        }
    }
    
    func addEntityToEntityRelation(name: String, parentSymbolName: String?, parentSymbolKind: String?, relationType: String?, graph: inout Graph) {
        guard
            let parentSymbolName = parentSymbolName,
            let parentSymbolKind = parentSymbolKind,
            let relationType = relationType,
            let relationKind = RelationKinds(rawValue: relationType)
        else {
            return
        }
        if graph.entities[parentSymbolName] == nil {
            graph.entities[parentSymbolName] = createEntity(name: parentSymbolName, kind: parentSymbolKind)
        }
        guard let entity = graph.entities[name] else {
            exit(1)
        }
        guard let parentEntity = graph.entities[parentSymbolName] else {
            exit(1)
        }
        if entity.relations[relationKind] == nil {
            graph.entities[name]!.relations[relationKind] = []
        }
        
        graph.entities[name]!.relations[relationKind]?.append(parentEntity)
        
        return
    }
    
}
