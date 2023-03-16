//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

protocol Symbol {
    associatedtype KindType
    var accessLevel: AccessLevelKinds { get set }
    var name: String { get set }
    var kind: KindType { get set }
    var type: SymbolType { get set }
}
