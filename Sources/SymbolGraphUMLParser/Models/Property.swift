//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

class Property: Symbol {
    typealias KindType = PropertyKinds
    
    var type: SymbolType = .property
    var accessLevel: AccessLevelKinds = .lpublic
    var name: String
    var types: [PropertyType] = []
    var kind: PropertyKinds
    var symbolType: SymbolType = .property
    
    var textType: String {
        var typeString = ""
        for type in types {
            typeString += "\(type.initialOperators)\(type.identifier)\(type.finalOperators)"
        }
        return typeString
    }
    
    var signature: String {
        "\(name): \(textType.map { if $0 == "(" || $0 == ")" { return "" }; return String($0) }.joined(separator: ""))"
    }
    
    init(accessLevel: AccessLevelKinds, name: String, types: [PropertyType], kind: PropertyKinds) {
        self.accessLevel = accessLevel
        self.name = name
        self.types = types
        self.kind = kind
    }
    
    
    func sanitizeProperties() {
        
        guard !types.isEmpty else { return }
        
        for (idx, type) in types.enumerated() {
            var mutableType = type
            mutableType.initialOperators = type.initialOperators.trimmingCharacters(in: .whitespacesAndNewlines)
            mutableType.finalOperators = type.finalOperators.trimmingCharacters(in: .whitespacesAndNewlines)
            if let removeCharacterIdx = type.initialOperators.firstIndex(of: "{") {
                types[idx].initialOperators.remove(at: removeCharacterIdx)
            }
            if let removeCharacterIdx = mutableType.finalOperators.firstIndex(of: "{") {
                mutableType.finalOperators.remove(at: removeCharacterIdx)
            }
            types[idx] = mutableType
        }
        var firstInitialOperator = types[0].initialOperators
        firstInitialOperator = String(firstInitialOperator[
            firstInitialOperator.index(after: firstInitialOperator.firstIndex(of: ":") ?? firstInitialOperator.startIndex)..<types[0].initialOperators.endIndex
        ])
        let lastFinalOperators = types.last!.finalOperators
        for (idx, _) in types.enumerated() {
            types[idx].finalOperators = ""
        }
        types[0].initialOperators = firstInitialOperator
        types[types.count - 1].finalOperators = lastFinalOperators
    }
}
