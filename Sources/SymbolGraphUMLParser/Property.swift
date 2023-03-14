//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

struct Property {

    var accessLevel: AccessLevelKinds = .lpublic
    var name: String
    var type: [PropertyType] = []
    var kind: PropertyKinds
    var symbolType: SymbolType = .property
}
