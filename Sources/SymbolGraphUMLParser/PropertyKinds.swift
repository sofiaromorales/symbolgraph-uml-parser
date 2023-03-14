//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 13/3/23.
//

import Foundation

enum PropertyKinds: String, CaseIterable {
    case property = "Instance Property"
    case lcase = "Case"
    case none = "none"
    
    static let propertyKinds = PropertyKinds.allCases.map { $0.rawValue }
    static let existingRelations = [RelationKinds.memberOf.rawValue, RelationKinds.requirementOf.rawValue]
}
