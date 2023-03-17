//
//  File.swift
//  
//
//  Created by Sofia Rodriguclearez Morales on 12/3/23.
//

import Foundation

class Entity: Symbol {
    
    typealias KindType = EntityKinds
    
    var accessLevel: AccessLevelKinds = .lpublic
    var type: SymbolType = .entity
    var name: String = ""
    var kind: EntityKinds = .other
    var properties: [String : Property] = [:]
    var methods: [String : Method] = [:]
    var generics: [String] = []
    
    var relations: [RelationKinds : [Entity]] = [:]
    
    var nameText: String {
        return name.contains(".") ? String(name[name.index(after: name.lastIndex(of: ".")!)...]) : name
    }
    
    init(name: String, kind: EntityKinds, generics: [String]) {
        self.name = name
        self.kind = kind
        self.generics = generics
    }
    
    func curateConformanceRelation() {
        guard let conformaceEntities = relations[.conformsTo] else { return }
        guard let parentEntities = relations[.inheritsFrom] else { return }
        for conformaceEntity in conformaceEntities {
            for parentEntity in parentEntities {
                guard let parentConformanceEntities = parentEntity.relations[.conformsTo] else { continue }
                for parentConformanceEntity in parentConformanceEntities {
                    guard parentConformanceEntity.kind == .lprotocol else { exit(1) }
                    if parentConformanceEntity.name == conformaceEntity.name {
                        // Remove relation
                        relations[.conformsTo] = relations[.conformsTo]!.filter { $0.name != conformaceEntity.name }
                    }
                }
            }
        }
    }


}
