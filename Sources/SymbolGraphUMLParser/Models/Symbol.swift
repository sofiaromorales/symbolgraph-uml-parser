//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

protocol Symbol {
    var accessLevel: AccessLevelKinds { get set }
    var name: String { get set }
    var kind: String { get set }
    var type: SymbolType { get set }
}
