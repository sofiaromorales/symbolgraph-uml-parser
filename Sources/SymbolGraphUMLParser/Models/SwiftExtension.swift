//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 18/5/23.
//

import Foundation

struct SwiftExtension {
    var extendedModule: String
    var constraints: [Constraint]
    struct Constraint: Decodable {
        var kind: String
        var rhs: String
        var lhs: String
        var rhsPrecise: String
    }
}
