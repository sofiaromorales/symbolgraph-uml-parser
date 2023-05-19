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
    init(swiftExtensionDTO: SymbolDTO.SwiftExtensionDTO) {
        self.extendedModule = swiftExtensionDTO.extendedModule
        var constraints: [Constraint] = []
        guard swiftExtensionDTO.constraints != nil else {
            self.constraints = []
            return
        }
        for constraint in swiftExtensionDTO.constraints! {
            constraints.append(Constraint(kind: constraint.kind, rhs: constraint.rhs, lhs: constraint.lhs, rhsPrecise: constraint.rhs))
        }
        self.constraints = constraints
    }
}
