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
        let extraParameters: [SwiftGenericDTO.Parameter] = []
//        if let genericsConstraints = generics.constraints {
//            for constriant in genericsConstraints {
//                if (!generics.parameters.contains(where: { parameter in
//                    parameter.name == constriant.lhs
//                })) {
//                    extraParameters.append(SwiftGenericDTO.Parameter(name: constriant.lhs, index: -1, depth: -1))
//                }
//            }
//        }
//        print("extraParameters")
//        print(extraParameters)
        for parameter in generics.parameters + extraParameters {
            conformances = []
            // if !parameterTypes.contains(parameter.name) { continue }
            if generics.constraints != nil {
                for constraint in generics.constraints! {
                    if constraint.lhs == parameter.name {
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
        signature.append("(\(parameters.joined(separator: ", ").replacingOccurrences(of: ")", with: "）")))")
        signature.append("\(returns.isEmpty ? "" : " \(returns.joined(separator: " ").replacingOccurrences(of: ")", with: "）"))")")
        return signature
    }
    
}

extension Method: Equatable {
    static func == (lhs: Method, rhs: Method) -> Bool {
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.kind == rhs.kind &&
        lhs.parameters == rhs.parameters &&
        lhs.returns == rhs.returns &&
        lhs.generics == rhs.generics
    }
}
