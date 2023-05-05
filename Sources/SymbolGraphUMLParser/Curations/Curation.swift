//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 16/3/23.
//

import Foundation

struct Curation {
    
    
    func curateEntityConformanceRelation(entity: inout Entity, parentEntities: [Entity]) {
        guard entity.relations[.conformsTo] != nil else { return }
        for parentEntity in parentEntities {
            removeConformanceRelation(entity: &entity, parentEntity: parentEntity)
            if (parentEntity.relations[.inheritsFrom] == nil && parentEntity.relations[.conformsTo] == nil) {
                continue
            }
            let parentRelations = (parentEntity.relations[.inheritsFrom] ?? []) + (parentEntity.relations[.conformsTo] ?? [])
            curateEntityConformanceRelation(entity: &entity, parentEntities: parentRelations.map { $0.0 })
        }
    }
    
    func removeConformanceRelation(entity: inout Entity, parentEntity: Entity) {
        guard let conformaceEntitiesRelations = entity.relations[.conformsTo] else {
            return
        }
        guard let parentConformaceEntitiesRelations = parentEntity.relations[.conformsTo] else {
            return
        }
        for conformanceEntityRelation in conformaceEntitiesRelations {
            let (conformanceEntity, _) = conformanceEntityRelation
            for parentConformanceEntityRelation in parentConformaceEntitiesRelations {
                let (parentConformanceEntity, _) = parentConformanceEntityRelation
                if conformanceEntity.name == parentConformanceEntity.name {
                    entity.relations[.conformsTo] = entity.relations[.conformsTo]!.filter { $0.0.name != parentConformanceEntity.name }
                }
            }
        }
    }
    
    func transformToExplicitAssociationDiagram(graph: inout SymbolGraphModel) {
        
        for entityDict in graph.entities {
            let entity = entityDict.value
            if (entity.relations[.associatedTo] == nil) {
                entity.relations[.associatedTo] = []
            }
            
            for (key, property) in entity.properties {
                guard property.types.count == 1 else { continue }
                let typeProperty = property.types[0]
                let propertyTypeIdentifier = typeProperty.identifier
                for entity2Dict in graph.entities {
                    let entity2 = entity2Dict.value
                    if propertyTypeIdentifier == entity2.name {
                        // CURATE RELATION
                        var multiplicity = "\(property.name) "
                        multiplicity.append(typeProperty.finalOperators == "]" ? "0 .. *" : "1")
                        
                        entity.relations[.associatedTo]!.append((entity2, multiplicity))
                        entity.properties.removeValue(forKey: key)
                    }
                }
            }
        }
        
    }
    
}
