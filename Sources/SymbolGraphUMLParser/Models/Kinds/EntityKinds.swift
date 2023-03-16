//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

public enum EntityKinds: String, CaseIterable, Kind {
    case structure = "Structure"
    case lclass = "Class"
    case enumeration = "Enumeration"
    case lprotocol = "Protocol"
    case lextension = "Extension"
    case other = "Other"
    
    static let entityKinds = EntityKinds.allCases.map { $0.rawValue }
    static let existingRelations = [RelationKinds.inheritsFrom]
    
}
