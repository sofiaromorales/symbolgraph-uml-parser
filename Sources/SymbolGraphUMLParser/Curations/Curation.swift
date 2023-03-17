//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 16/3/23.
//

import Foundation

struct Curation {
    
    
    func curateEntityConformanceRelation(entity: inout Entity, parentEntities: [Entity]) {
        guard let conformaceEntities = entity.relations[.conformsTo] else { return }
        
        for (idx, parentEntity) in parentEntities.enumerated() {
            removeConformanceRelation(entity: &entity, parentEntity: parentEntity)
            if (parentEntity.relations[.inheritsFrom] == nil && parentEntity.relations[.conformsTo] == nil) {
                continue
            }
            let parents = (parentEntity.relations[.inheritsFrom] ?? []) + (parentEntity.relations[.conformsTo] ?? [])
            curateEntityConformanceRelation(entity: &entity, parentEntities: parents)
        }
        
    }
    
    func removeConformanceRelation(entity: inout Entity, parentEntity: Entity) {
        guard let conformaceEntities = entity.relations[.conformsTo] else {
            return
        }
        guard let parentConformaceEntities = parentEntity.relations[.conformsTo] else {
            return
        }
        for conformanceEntity in conformaceEntities {
            for parentConformanceEntity in parentConformaceEntities {
                if conformanceEntity.name == parentConformanceEntity.name {
                    entity.relations[.conformsTo] = entity.relations[.conformsTo]!.filter { $0.name != parentConformanceEntity.name }
                }
            }
            
        }
    }
    
}
