//
//  CurationTests.swift
//  
//
//  Created by Sofia Rodriguez Morales on 3/5/23.
//

import XCTest
@testable import SymbolGraphUMLParser

class CurationTests: XCTestCase {
    
    var curator = Curation()
    
    func testRemoveConformanceRelation() {
        let protocol1 = Entity(name: "P1", kind: .lprotocol, generics: nil)
        let protocol2 = Entity(name: "P2", kind: .lprotocol, generics: nil)
        let C1 = Entity(name: "C1", kind: .lclass, generics: nil)
        var C2 = Entity(name: "C2", kind: .lclass, generics: nil)
        C1.relations[.conformsTo] = []
        C2.relations[.conformsTo] = []
        C2.relations[.inheritsFrom] = []
        C1.relations[.conformsTo]?.append((protocol1, nil))
        C2.relations[.conformsTo]?.append((protocol1, nil))
        C2.relations[.conformsTo]?.append((protocol2, nil))
        C2.relations[.inheritsFrom]?.append((C1, nil))
        XCTAssertTrue(C2.relations[.conformsTo]!.count == 2)
        curator.removeConformanceRelation(entity: &C2, parentEntity: C1)
        XCTAssertTrue(C2.relations[.conformsTo]!.count == 1)
    }

    func testCurateEntityConformanceRelation() {
        
        /*
         public protocol P1 {}
         public protocol P2: P1 {}
         public class C1: P1 {}
         public class C2: C1, P2 {}
         public class C3: C1 {}
         public class C4: C3 {}
         */
        
        let P1 = Entity(name: "P1", kind: .lprotocol, generics: nil)
        let P2 = Entity(name: "P2", kind: .lprotocol, generics: nil)
        let C1 = Entity(name: "C1", kind: .lclass, generics: nil)
        var C2 = Entity(name: "C2", kind: .lclass, generics: nil)
        var C3 = Entity(name: "C3", kind: .lclass, generics: nil)
        var C4 = Entity(name: "C4", kind: .lclass, generics: nil)
        
        P2.relations[.conformsTo] = []
        C1.relations[.conformsTo] = []
        C2.relations[.conformsTo] = []
        C3.relations[.conformsTo] = []
        C4.relations[.conformsTo] = []
        C2.relations[.inheritsFrom] = []
        C3.relations[.inheritsFrom] = []
        C4.relations[.inheritsFrom] = []
        
        P2.relations[.conformsTo]?.append((P1, nil))
        C1.relations[.conformsTo]?.append((P1, nil))
        C2.relations[.conformsTo]?.append((P1, nil))
        C2.relations[.conformsTo]?.append((P2, nil))
        C3.relations[.conformsTo]?.append((P1, nil))
        C4.relations[.conformsTo]?.append((P1, nil))
        
        C2.relations[.inheritsFrom]?.append((C1, nil))
        C3.relations[.inheritsFrom]?.append((C1, nil))
        C4.relations[.inheritsFrom]?.append((C3, nil))
        
        XCTAssertTrue(C2.relations[.conformsTo]!.count == 2)
        XCTAssertTrue(C2.relations[.inheritsFrom]!.count == 1)
        var parentRelations = (C2.relations[.inheritsFrom] ?? []) + (C2.relations[.conformsTo] ?? [])
        curator.curateEntityConformanceRelation(entity: &C2, parentEntities: parentRelations.map { $0.0 })
        XCTAssertTrue(C2.relations[.conformsTo]!.count == 1)
        XCTAssertTrue(C2.relations[.inheritsFrom]!.count == 1)
        
        XCTAssertTrue(C3.relations[.conformsTo]!.count == 1)
        XCTAssertTrue(C4.relations[.conformsTo]!.count == 1)
        parentRelations = (C4.relations[.inheritsFrom] ?? []) + (C4.relations[.conformsTo] ?? [])
        curator.curateEntityConformanceRelation(entity: &C4, parentEntities: parentRelations.map { $0.0 })
        parentRelations = (C3.relations[.inheritsFrom] ?? []) + (C3.relations[.conformsTo] ?? [])
        curator.curateEntityConformanceRelation(entity: &C3, parentEntities: parentRelations.map { $0.0 })
        XCTAssertTrue(C3.relations[.conformsTo]!.count == 0)
        XCTAssertTrue(C4.relations[.conformsTo]!.count == 0)
    }
    
    func testTransformToExplicitAssociationDiagram() {
        
        let P1 = Entity(name: "P1", kind: .lprotocol, generics: nil)
        let P2 = Entity(name: "P2", kind: .lprotocol, generics: nil)
        let C1 = Entity(name: "C1", kind: .lclass, generics: nil)
        let C2 = Entity(name: "C2", kind: .lclass, generics: nil)
        let S1 = Entity(name: "S1", kind: .structure, generics: nil)
        
        let intP1 = Property(accessLevel: .lpublic, name: "intP1", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        let foop2p1 = Property(accessLevel: .lpublic, name: "foop2p1", types: [PropertyType(identifier: "P1", initialOperators: "", finalOperators: "")], kind: .property)
        let fooc1c2 = Property(accessLevel: .lpublic, name: "fooc1c2", types: [PropertyType(identifier: "C2", initialOperators: "", finalOperators: "")], kind: .property)
        let fooc2p1 = Property(accessLevel: .lpublic, name: "fooc2p1", types: [PropertyType(identifier: "P1", initialOperators: "", finalOperators: "")], kind: .property)
        let foos2c1 = Property(accessLevel: .lpublic, name: "foos2c1", types: [PropertyType(identifier: "C1", initialOperators: "", finalOperators: "")], kind: .property)
        let foos2c2 = Property(accessLevel: .lpublic, name: "foos2c2", types: [PropertyType(identifier: "C2", initialOperators: "", finalOperators: "")], kind: .property)
        
        P1.properties = [intP1.name:intP1]
        P2.properties = [foop2p1.name:foop2p1]
        C1.properties = [fooc1c2.name:fooc1c2]
        C2.properties = [fooc2p1.name:fooc2p1]
        S1.properties = [foos2c1.name:foos2c1, foos2c2.name:foos2c2]
        
        var graph = SymbolGraphModel(
            entities: [P1.name:P1, P2.name:P2, C1.name:C1, C2.name:C2, S1.name:S1],
            properties: [:],
            methods: [:]
        )
        
        curator.transformToExplicitAssociationDiagram(graph: &graph)
        
        XCTAssertTrue(P1.relations[.associatedTo]!.isEmpty)
        XCTAssertTrue(P2.relations[.associatedTo]![0].0 == P1 && P2.relations[.associatedTo]![0].1 == "foop2p1 1")
        XCTAssertTrue(C1.relations[.associatedTo]![0].0 == C2 && C1.relations[.associatedTo]![0].1 == "fooc1c2 1")
        XCTAssertTrue(C2.relations[.associatedTo]![0].0 == P1 && C2.relations[.associatedTo]![0].1 == "fooc2p1 1")
        XCTAssertTrue(S1.relations[.associatedTo]![0].0 == C1 && S1.relations[.associatedTo]![0].1 == "foos2c1 1")
        XCTAssertTrue(S1.relations[.associatedTo]![1].0 == C2 && S1.relations[.associatedTo]![1].1 == "foos2c2 1")

    }
    
    func testTransformToExplicitAssociationDiagramArray() {
        
        let P1 = Entity(name: "P1", kind: .lprotocol, generics: nil)
        let P2 = Entity(name: "P2", kind: .lprotocol, generics: nil)
        let C1 = Entity(name: "C1", kind: .lclass, generics: nil)
        let C2 = Entity(name: "C2", kind: .lclass, generics: nil)
        let S1 = Entity(name: "S1", kind: .structure, generics: nil)
        
        let intP1 = Property(accessLevel: .lpublic, name: "intP1", types: [PropertyType(identifier: "Int", initialOperators: "[", finalOperators: "]")], kind: .property)
        let foop2p1 = Property(accessLevel: .lpublic, name: "foop2p1", types: [PropertyType(identifier: "P1", initialOperators: "[", finalOperators: "]")], kind: .property)
        let fooc1c2 = Property(accessLevel: .lpublic, name: "fooc1c2", types: [PropertyType(identifier: "C2", initialOperators: "[", finalOperators: "]")], kind: .property)
        let fooc2p1 = Property(accessLevel: .lpublic, name: "fooc2p1", types: [PropertyType(identifier: "P1", initialOperators: "[", finalOperators: "]")], kind: .property)
        let foos2c1 = Property(accessLevel: .lpublic, name: "foos2c1", types: [PropertyType(identifier: "C1", initialOperators: "[", finalOperators: "]")], kind: .property)
        let foos2c2 = Property(accessLevel: .lpublic, name: "foos2c2", types: [PropertyType(identifier: "C2", initialOperators: "[", finalOperators: "]")], kind: .property)
        
        P1.properties = [intP1.name:intP1]
        P2.properties = [foop2p1.name:foop2p1]
        C1.properties = [fooc1c2.name:fooc1c2]
        C2.properties = [fooc2p1.name:fooc2p1]
        S1.properties = [foos2c1.name:foos2c1, foos2c2.name:foos2c2]
        
        var graph = SymbolGraphModel(
            entities: [P1.name:P1, P2.name:P2, C1.name:C1, C2.name:C2, S1.name:S1],
            properties: [:],
            methods: [:]
        )
        
        curator.transformToExplicitAssociationDiagram(graph: &graph)
        
        XCTAssertTrue(P1.relations[.associatedTo]!.isEmpty)
        XCTAssertTrue(P2.relations[.associatedTo]![0].0 == P1 && P2.relations[.associatedTo]![0].1 == "foop2p1 0 .. *")
        XCTAssertTrue(C1.relations[.associatedTo]![0].0 == C2 && C1.relations[.associatedTo]![0].1 == "fooc1c2 0 .. *")
        XCTAssertTrue(C2.relations[.associatedTo]![0].0 == P1 && C2.relations[.associatedTo]![0].1 == "fooc2p1 0 .. *")
        XCTAssertTrue(S1.relations[.associatedTo]![0].0 == C1 && S1.relations[.associatedTo]![0].1 == "foos2c1 0 .. *")
        XCTAssertTrue(S1.relations[.associatedTo]![1].0 == C2 && S1.relations[.associatedTo]![1].1 == "foos2c2 0 .. *")
        
    }
    
    func testTransformToExplicitAssociationDiagramDictionary() {
        let P1 = Entity(name: "P1", kind: .lprotocol, generics: nil)
        let C1 = Entity(name: "C1", kind: .lclass, generics: nil)
        let foo = Property(accessLevel: .lpublic, name: "fooc1c2", types: [PropertyType(identifier: "Int", initialOperators: "[", finalOperators: ""), PropertyType(identifier: "C2", initialOperators: ":", finalOperators: "]")], kind: .property)
        C1.properties = [foo.name:foo]
        var graph = SymbolGraphModel(
            entities: [P1.name:P1, C1.name:C1],
            properties: [:],
            methods: [:]
        )
        curator.transformToExplicitAssociationDiagram(graph: &graph)
        XCTAssertTrue(C1.relations[.associatedTo]!.isEmpty)
    }

}
