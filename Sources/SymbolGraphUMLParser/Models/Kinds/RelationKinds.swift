//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

enum RelationKinds: String, Kind {
    case memberOf = "memberOf"
    case conformsTo = "conformsTo"
    case extensionTo = "extensionTo"
    case requirementOf = "requirementOf"
    case inheritsFrom = "inheritsFrom"
    case aggregatedTo = "aggregatedTo"
    case associatedTo = "associatedTo"
    case overrides = "overrides"
    case defaultImplementationOf = "defaultImplementationOf"
    
    static let extensionRelationships = [overrides.rawValue, requirementOf.rawValue, defaultImplementationOf.rawValue]
}
