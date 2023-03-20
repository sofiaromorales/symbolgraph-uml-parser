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
    
    func drawRelationArrow(_ relationType: RelationKinds, multiplicity: String?) -> String {
        if relationType == .inheritsFrom {
            return "<|--"
        }
        if relationType == .conformsTo {
            return "<|.."
        }
        if relationType == .memberOf {
            return "\"namespace\"*--\"ownedMember\""
        }
        if relationType == .associatedTo {
            guard let multiplicity = multiplicity else {
                return "<--"
            }
            let propertyName = multiplicity[...(multiplicity.firstIndex(of: " ") ?? multiplicity.startIndex)]
            let propertyMultiplicity = multiplicity[(multiplicity.firstIndex(of: " ") ?? multiplicity.startIndex)...]
            return "\"\(propertyName)\"<--\"\(propertyMultiplicity)\""
        }
        return ""
    }
    
    func drawRelations(_ entity: Entity) -> String {
        var diagramRelations = ""
        for relationType in Array(entity.relations.keys) {
            guard let relatedEntitiesRelations = entity.relations[relationType] else {
                diagramRelations.append("")
                continue
            }
            for relatedEntityRelation in relatedEntitiesRelations {
                let (relatedEntity, multiplicity) = relatedEntityRelation
                diagramRelations.append("\t\(relatedEntity.nameText) \(drawRelationArrow(relationType, multiplicity: multiplicity)) \(entity.nameText)\n")
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
            class \(entity.nameText) \(!entity.generics!.parameters.isEmpty ? "~" : "")\(entity.generics?.genericsText ?? "")\(!entity.generics!.parameters.isEmpty ? "~" : "") {
            \(drawEntityType(entity.kind))
            \(drawEntityProperties(Array(entity.properties.values.sorted { $0.signature < $1.signature })))
            \(drawEntityMethods(Array(entity.methods.values.sorted { $0.signature < $1.signature })))
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
