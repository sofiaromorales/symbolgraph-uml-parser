//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 15/3/23.
//

import Foundation

struct MermaidParser: TextUMLClassParser {
    
    func convertAccessLevel(_ accessLevel: AccessLevelKinds) -> String {
        switch accessLevel {
        case .lpublic: return "+"
        case .lprivate: return "-"
        case .linternal: return "〜"
        case .lfileprivate: return "#"
        default: return "undefined"
        }
    }
    
    func drawEntityProperties(_ properties: [Property]) -> String {
        var diagramProps = ""
        for property in properties {
            if (property.kind == .lcase) {
                diagramProps.append(
                    "\t\(property.signature)\n"
                )
            } else {
                var propertySignature = property.signature
                propertySignature = propertySignature.replacingOccurrences(of: "(", with: "⦅")
                propertySignature = propertySignature.replacingOccurrences(of: ")", with: "⦆")
                propertySignature = propertySignature.replacingOccurrences(of: "<", with: "[")
                propertySignature = propertySignature.replacingOccurrences(of: "->", with: " → ")
                propertySignature = propertySignature.replacingOccurrences(of: ">", with: "]")
                
                diagramProps.append(
                    "\t\(convertAccessLevel(property.accessLevel)) \(property.kind == .lcase ? "case " : "")\(propertySignature)\n"
                )
            }
        }
        return diagramProps
    }
    
    func drawEntityMethods(_ methods: [Method]) -> String {
        var diagramMethods = ""
        for method in methods {
            diagramMethods.append(
                "\t\(convertAccessLevel(method.accessLevel)) \(method.signature)\n"
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
    
    func drawRelationArrow(_ relationType: RelationKinds, multiplicity: String?, entity: Entity) -> String {
        if relationType == .inheritsFrom {
            return "<|--"
        }
        if relationType == .conformsTo {
            return "<|.."
        }
        if relationType == .memberOf {
            return "*--"
        }
        if relationType == .associatedTo {
            guard let multiplicity = multiplicity else {
                return "<--"
            }
            let propertyName = multiplicity[...(multiplicity.firstIndex(of: " ") ?? multiplicity.startIndex)]
            let propertyMultiplicity = multiplicity[(multiplicity.firstIndex(of: " ") ?? multiplicity.startIndex)...]
            return "\"\(propertyName)\"<--\"\(propertyMultiplicity)\""
        }
        if relationType == .extensionTo {
            guard let entityExtension = entity.swiftExtension else {
                return "..>"
            }
            var constrainedRelationship = ""
            for constaint in entityExtension.constraints {
                constrainedRelationship += "\"{\(constaint.lhs):\(constaint.rhs)}\""
            }
            return constrainedRelationship + "..>"
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
            // For every relation of the entity of type `relationType`
            for relatedEntityRelation in relatedEntitiesRelations {
                let (relatedEntity, multiplicity) = relatedEntityRelation
                diagramRelations.append("\t\(relatedEntity.nameText) \(drawRelationArrow(relationType, multiplicity: multiplicity, entity: relatedEntityRelation.0)) \(entity.nameText)")
                if (relationType == .memberOf) {
                    diagramRelations.append(" : ≪nested≫")
                }
                else if (relationType == .extensionTo) {
                    diagramRelations.append(" : ≪extension≫")
                }
                diagramRelations.append("\n")
            }
        }
        return diagramRelations
    }
    
    func drawEntityHeader(_ entity: Entity) -> String {
        var entityHeader = "\(entity.nameText)"
//        if let entityExtension = entity.swiftExtension {
//            if !entityExtension.constraints.isEmpty {
//                entityHeader += "\n"
//                entityExtension.constraints.forEach {
//                    entityHeader += "{\($0.rhs):\($0.lhs)}\n"
//                }
//            }
//        }
//        entityHeader += "`"
        if let entityGenerics = entity.generics {
            guard let constraints = entityGenerics.constraints else { return entityHeader }
            if !constraints.isEmpty {
                entityHeader += " ~\(entityGenerics.genericsText)~"
            }
        }
        return entityHeader
    }
    
    func parse(entities: [Entity]) -> String {
        if entities.isEmpty { return "" }
            
        var diagram = """
        classDiagram \n
        """
        for entity in entities {
            if entity.properties.isEmpty && entity.methods.isEmpty && entity.kind == .lclass { continue }
            let entityClass = """
            class \(drawEntityHeader(entity)) {
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
