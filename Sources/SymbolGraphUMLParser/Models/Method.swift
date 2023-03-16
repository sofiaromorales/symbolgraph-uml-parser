//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

struct Method: Symbol {
    
    typealias KindType = String
    
    var accessLevel: AccessLevelKinds = .lpublic
    var type: SymbolType = .method
    var name: String
    var kind: String
    var parameters: [String] = []
    var returns: [String] = []
    var signature: String {
        "\(name)(\(parameters.joined(separator: ", "))) \(returns.isEmpty ? "" : " -> \(returns.joined(separator: ", "))")"
    }
    
}
