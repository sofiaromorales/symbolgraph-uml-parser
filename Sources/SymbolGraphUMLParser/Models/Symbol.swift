//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

protocol Symbol: Equatable {
    associatedtype KindType: Equatable
    var accessLevel: AccessLevelKinds { get set }
    var name: String { get set }
    var kind: KindType { get set }
    var type: SymbolType { get set }
}

extension Symbol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type && lhs.kind == rhs.kind
    }
}
