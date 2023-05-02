//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 15/3/23.
//

import Foundation

struct SymbolGraphModel {
    
    var entities: [String : Entity] = [:]
    var properties: [String: Property] = [:]
    var methods: [String: Method] = [:]
    
    init() {}
    
    init(entities: [String : Entity], properties: [String: Property], methods: [String: Method]) {
        self.entities = entities
        self.properties = properties
        self.methods = methods
    }
    
}
