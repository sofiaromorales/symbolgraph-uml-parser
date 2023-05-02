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
    
    var textType: String {
        var typeString = ""
        let fullType = types.map { $0.initialOperators + $0.identifier + $0.finalOperators }.joined()
        if (fullType.contains("->") || types.count > 1) { typeString += "（" }
        for (idx, type) in types.enumerated() {
            if (type.initialOperators.contains("() ->")) {
                typeString += "（）-> "
            }
//            if (type.initialOperators.contains("->")) {
//                typeString += "（"
//            }]
            if type.initialOperators.contains("[") { typeString += " [" }
            typeString += type.identifier
            if (
                (type.finalOperators.contains("]") && !type.finalOperators.contains("[readOnly]")) ||
                (type.finalOperators.filter({ $0 == "]"}).count > 1 && type.finalOperators.contains("[readOnly]"))
            ) { typeString += "]" }
            if (idx + 1 != types.endIndex) {
                if (!types[idx + 1].initialOperators.contains("->")) {
                    typeString += ", "
                }
                if (types[idx + 1].initialOperators.contains("->")) {
                    typeString += "）-> "
                }
            }
        }
        if (!fullType.contains("->") && types.count > 1) { typeString += "）" }
        if (fullType.contains("[readOnly]")) { typeString += " [readOnly]"}
        return typeString
    }
    
    var signature: String {
        let compundNameIndex = name.lastIndex(of: ".")
        let minimizedName = compundNameIndex != nil ? String(name[(name.index(after: name.lastIndex(of: ".") ?? name.startIndex))...]) : name
        return "\(minimizedName): \(textType)"
//        return "\(minimizedName)\(textType.isEmpty ? "" : ":") \(textType.map { if $0 == "(" || $0 == ")" { return "" }; return String($0) }.joined(separator: ""))"
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

extension Property: Equatable {
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.kind == rhs.kind &&
        lhs.types == rhs.types
    }
}
