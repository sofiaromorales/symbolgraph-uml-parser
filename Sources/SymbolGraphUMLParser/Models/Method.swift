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
    var generics: SwiftGenericDTO? = nil
    
    var genericsTextRepresentation: String {
        let parameterTypes = parameters.map {
            return String($0[$0.index(after: $0.lastIndex(of: " ")!)...])
        }
        guard let generics = generics else { return "" }
        var genericsText: [String] = []
        var conformances: [String] = []
        for parameter in generics.parameters {
            conformances = []
            if !parameterTypes.contains(parameter.name) { continue }
            if generics.constraints != nil {
                for constraint in generics.constraints! {
                    if constraint.lhs == parameter.name && constraint.kind == "conformance" {
                        conformances.append(constraint.rhs)
                    }
                }
            }
            genericsText.append("\(parameter.name)\(!conformances.isEmpty ? ": \(conformances.joined(separator: ", "))" : "")")
        }
        if genericsText.isEmpty { return "" }
        return "~" + genericsText.joined(separator: ", ") + "~"

    }
    var signature: String {
        var signature = name
        if let _ = generics {
            signature.append(genericsTextRepresentation)
        }
        signature.append("(\(parameters.joined(separator: ", ")))")
        signature.append("\(returns.isEmpty ? "" : " \(returns.joined(separator: " "))")")
        return signature
    }
    
}
