//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 17/3/23.
//

import Foundation

struct SwiftGenerics: Decodable {
    
    var genericsText: String {
        var generics: [String] = []
        var conformances: [String] = []
        for parameter in parameters {
            conformances = []
            for constraint in constraints {
                if constraint.lhs == parameter.name && constraint.kind == "conformance" {
                    conformances.append(constraint.rhs)
                }
            }
            generics.append("\(parameter.name)\(!conformances.isEmpty ? ": \(conformances.joined(separator: ", "))" : "")")
        }
        return generics.joined(separator: ", ")
    }
    
    var parameters: [Parameter] = []
    var constraints: [Constraint] = []
    
    
    init(json: String) {
        do {
            let generic = try transform(json)
            print("generic")
            print(generic)
            self.parameters = generic.parameters
            self.constraints = generic.constraints
        } catch {
            self.parameters = []
            self.constraints = []
            return
        }
    }
    
    init(parameters: [Parameter], constraints: [Constraint]) {
        self.parameters = parameters
        self.constraints = constraints
    }
    
    func transform(_ json: String) throws -> SwiftGenerics {
        if let dataFromJSON = json.data(using: .utf8) {
            let swiftGeneric = try JSONDecoder().decode(SwiftGenerics.self, from: dataFromJSON)
            return swiftGeneric
        }
        return SwiftGenerics(parameters: [], constraints: [])
        
    }
    
    struct Parameter: Decodable {
        var name: String
        var index: Int
        var depth: Int
    }
    
    struct Constraint: Decodable {
        var kind: String
        var rhs: String
        var lhs: String
    }
}
