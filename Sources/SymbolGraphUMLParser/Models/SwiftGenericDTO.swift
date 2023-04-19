//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 17/3/23.
//

import Foundation

struct SwiftGenericDTO: DTO {
    typealias T = SwiftGenericDTO
    
    
    
    var parameters: [Parameter] = []
    var constraints: [Constraint]? = []
    var genericsText: String {
        var generics: [String] = []
        var conformances: [String] = []
        for parameter in parameters {
            conformances = []
            if constraints != nil {
                for constraint in constraints! {
                    if constraint.lhs == parameter.name && constraint.kind == "conformance" {
                        conformances.append(constraint.rhs)
                    }
                }
            }
            generics.append("\(parameter.name)\(!conformances.isEmpty ? ": \(conformances.joined(separator: ", "))" : "")")
        }
        return generics.joined(separator: ", ")
    }
    
    
    init(json: String) {
        do {
            let generic = try transform(json)
            self.parameters = generic.parameters
            self.constraints = generic.constraints
        } catch {
            print("Error ocurred \(error)")
            self.parameters = []
            self.constraints = []
            return
        }
    }
    
    init(parameters: [Parameter], constraints: [Constraint]) {
        self.parameters = parameters
        self.constraints = constraints
    }
    
    func transform(_ json: String) throws -> SwiftGenericDTO {
        if let dataFromJSON = json.data(using: .utf8) {
            let swiftGeneric = try JSONDecoder().decode(SwiftGenericDTO.self, from: dataFromJSON)
            return swiftGeneric
        }
        return SwiftGenericDTO(parameters: [], constraints: [])
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
