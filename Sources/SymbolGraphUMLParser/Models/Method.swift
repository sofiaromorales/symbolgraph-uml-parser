//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

struct Method: Symbol {
    
    var accessLevel: AccessLevelKinds = .lpublic
    var type: SymbolType = .method
    var name: String
    var kind: String
    var parameters: [String] = []
    var returns: [String] = []
    
}
