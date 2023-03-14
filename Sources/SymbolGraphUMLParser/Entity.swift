//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

struct Entity: Symbol {
    
    var accessLevel: AccessLevelKinds = .lpublic
    var type: SymbolType = .entity
    var name: String
    var kind: String
    var properties: [String : Property] = [:]
    var methods: [String : Method] = [:]
    
    var relations: [RelationKinds : [Entity]] = [:]

}
