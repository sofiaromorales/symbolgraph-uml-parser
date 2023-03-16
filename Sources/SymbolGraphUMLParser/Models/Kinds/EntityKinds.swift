//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/3/23.
//

import Foundation

public enum EntityKinds: String, CaseIterable {
    case Structure = "Structure"
    case Class = "Class"
    case Enumeration = "Enumeration"
    case lProtocol = "Protocol"
    case Extension = "Extension"
    
    static let entityKinds = EntityKinds.allCases.map { $0.rawValue }
    static let existingRelations = [RelationKinds.inheritsFrom]
    
}
