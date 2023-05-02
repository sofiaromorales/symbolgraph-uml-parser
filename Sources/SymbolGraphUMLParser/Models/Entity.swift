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
    var generics: SwiftGenericDTO? = nil
    // var generics: [[String: [String: [String]]]] = []
    
    var relations: [RelationKinds : [(Entity, String?)]] = [:]
    
    var nameText: String {
        return "`\(name)`"
    }
    
    init(name: String, kind: EntityKinds, generics: SwiftGenericDTO?) {
        self.name = name
        self.kind = kind
        self.generics = generics
    }
    
//    func curateConformanceRelation() {
//        guard let conformaceEntitiesRelations = relations[.conformsTo] else { return }
//        guard let parentRelations = relations[.inheritsFrom] else { return }
//        for conformaceEntityRelation in conformaceEntitiesRelations {
//            let conformanceEntity = conformaceEntityRelation.0
//            for parentRelation in parentRelations {
//                guard let parentConformanceEntitiesRelations = parentRelation.0.relations[.conformsTo] else { continue }
//                for parentConformanceEntityRelation in parentConformanceEntitiesRelations {
//                    let parentConformanceEntity = parentConformanceEntityRelation.0
//                    guard parentConformanceEntity.kind == .lprotocol else { exit(1) }
//                    if parentConformanceEntity.name == conformanceEntity.name {
//                        // Remove relation
//                        relations[.conformsTo] = relations[.conformsTo]!.filter { $0.0.name != conformanceEntity.name }
//                    }
//                }
//            }
//        }
//    }
}

extension Entity: Equatable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.type == rhs.type &&
        lhs.name == rhs.name &&
        lhs.kind == rhs.kind &&
        lhs.generics == rhs.generics
    }
}
