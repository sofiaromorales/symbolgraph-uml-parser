//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 15/3/23.
//

import Foundation

struct MermaidParser {
    
    func convertAccessLevel(_ accessLevel: AccessLevelKinds) -> String {
        switch accessLevel {
        case .lpublic: return "+"
        case .lprivate: return "-"
        case .lineternal: return "〜"
        case .lfileprivate: return "#"
        default: return "undefined"
        }
    }
    
    func drawEntityProperties(_ properties: [Property]) -> String {
        var diagramProps = ""
        for property in properties {
            diagramProps.append(
            "\t \(convertAccessLevel(property.accessLevel))\(property.signature)\n"
            )
        }
        return diagramProps
    }
    
    func drawEntityMethods(_ methods: [Method]) -> String {
        var diagramMethods = ""
        for method in methods {
            diagramMethods.append(
                "\t \(convertAccessLevel(method.accessLevel))\(method.signature)\n"
            )
        }
        return diagramMethods
    }
    
    func drawEntityType(_ entityKind: EntityKinds) -> String {
        if (entityKind != .lclass) {
            return "\t<<\(entityKind.rawValue)>>"
        }
        return ""
    }
    
    func drawRelationArrow(_ relationType: RelationKinds) -> String {
        if relationType == .inheritsFrom {
            return "<|--"
        }
        if relationType == .conformsTo {
            return "<|.."
        }
        if relationType == .memberOf {
            return "\"namespace\"*--\"ownedBy\""
        }
        return ""
    }
    
    func drawRelations(_ entity: Entity) -> String {
        var diagramRelations = ""
        for relationType in Array(entity.relations.keys) {
            guard let relatedEntities = entity.relations[relationType] else {
                diagramRelations.append("")
                continue
            }
            for relatedEntity in relatedEntities {
                diagramRelations.append("\t\(relatedEntity.nameText) \(drawRelationArrow(relationType)) \(entity.nameText)\n")
            }
        }
        return diagramRelations
    }
    
    
    func parse(entities: [Entity]) -> String {
        
        var diagram = """
        classDiagram \n
        """
        
        for entity in entities {
            if entity.properties.isEmpty && entity.kind == .lclass { continue }
            let entityClass = """
            class \(entity.nameText) \(!entity.generics.isEmpty ? "~\(entity.generics.joined(separator: ", "))~" : ""){
            \(drawEntityType(entity.kind))
            \(drawEntityProperties(Array(entity.properties.values)))
            \(drawEntityMethods(Array(entity.methods.values)))
            } \n
            """
            diagram.append(entityClass)
        }
        
        for entity in entities {
            diagram.append("\(drawRelations(entity))")
        }
        
        return diagram
    }
}
