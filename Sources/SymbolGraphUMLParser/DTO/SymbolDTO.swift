//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 17/3/23.
//

import Foundation

struct SymbolDTO: DTO {
    typealias T = SymbolDTO
    

    var location: Location? = nil
    var declarationFragments: [Construct] = []
    var functionSignature: FunctionSignature? = nil
    // var parameters: [Parameter]
    var identifier: Identifier = Identifier(precise: "", interfaceLanguage: "")
    var kind: Kind = Kind(displayName: "", identifier: "")
    var accessLevel: String = "public"
    var pathComponents: [String] = []
    var names: Names = Names(title: "", subHeading: [])
    var swiftGenerics: SwiftGenericDTO? = nil
    
    
    
    init(json: String) {
        do {
            let symbol = try transform(json)
            // self.parameters = symbol.parameters
            self.identifier = symbol.identifier
            self.kind = symbol.kind
            self.accessLevel = symbol.accessLevel
            self.pathComponents = symbol.pathComponents
            self.names = symbol.names
            self.location = symbol.location
            self.declarationFragments = symbol.declarationFragments
            self.functionSignature = symbol.functionSignature
            self.swiftGenerics = symbol.swiftGenerics
//            self.navigator = symbol.navigator
//            self.subHeading = symbol.subHeading
        } catch {
            print("Error ocurred \(error)")
            print(json)
            exit(1)
        }
    }
    
    func transform(_ json: String) throws -> SymbolDTO {
        guard let dataFromJSON = json.data(using: .utf8) else { exit(1) }
        let symbolDTO = try JSONDecoder().decode(SymbolDTO.self, from: dataFromJSON)
        return symbolDTO
    }
    
    
    struct Location: Decodable {
        var uri: String
        var position: Position
        
        struct Position: Decodable {
            var line: Int
            var character: Int
        }
    }
    
    struct Parameter: Decodable {
        var name: String
        var index: Int
        var depth: Int
    }
    
    struct Identifier: Decodable {
        var precise: String
        var interfaceLanguage: String
    }
    
    struct Kind: Decodable {
        var displayName: String
        var identifier: String
    }
    
    struct Construct: Decodable {
        var kind: String
        var spelling: String
        var preciseIdentifier: String? = nil
    }
    
    struct Names: Decodable {
        var title: String
        var navigator: [Construct]? = nil
        var subHeading: [Construct]
    }
    
    struct FunctionSignature: Decodable {
        var returns: [Construct]?
        var parameters: [FunctionSignatureParameter]?
        
        struct FunctionSignatureParameter: Decodable {
            var name: String
            var declarationFragments: [Construct]
        }
    }
    
    struct Constraint: Decodable {
        var kind: String
        var rhs: String
        var lhs: String
    }
    
    struct SwiftGenericDTO: Decodable {
        var constraints: [Constraint]?
        var parameters: [Parameter]?
    }
    
}

