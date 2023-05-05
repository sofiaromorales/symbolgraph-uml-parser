//
//  MermaidParserTests.swift
//  
//
//  Created by Sofia Rodriguez Morales on 4/5/23.
//

import XCTest
@testable import SymbolGraphUMLParser

class MermaidParserTests: XCTestCase {
    
    let mermaidParser = MermaidParser()

    func testConvertAccessLevel() {
        XCTAssertEqual(mermaidParser.convertAccessLevel(.lpublic), "+")
        XCTAssertEqual(mermaidParser.convertAccessLevel(.lprivate), "-")
        XCTAssertEqual(mermaidParser.convertAccessLevel(.linternal), "〜")
        XCTAssertEqual(mermaidParser.convertAccessLevel(.lfileprivate), "#")
    }
    
    func testDrawEntityProperties() {
        
        // var foo = 1
        var property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: Int\n")
        
        // var foo = ""
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: String\n")
//
//        // var foo: [Int] = []
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: [Int]\n")
//
//        // var foo: [[String]] = [[]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [[", finalOperators: "]]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: [[String]]\n")
//
//        // var foo: (Int, String, Bool, Int) = ()
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (Int, String, Bool, Int）\n")
//
//        // var foo: [String: String] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: "]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: ( [String:String]）\n")
//
//        // var foo: [Int: (Bool, Int)] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ": (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: ( [Int:(Bool, Int）]）\n")
//
//        // var foo: Int?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "?")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: Int?\n")
//
//        // var foo: [Int]?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]?")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: [Int]?\n")
//
//        // var foo: [Int?]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "?]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: [Int?]\n")
//
//        // var foo: P
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "P", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: P\n")
//
//        // var foo: T
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "T", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: T\n")
//
//        // var foo: () -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Void", initialOperators: " () ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (）-> Void\n")
//
//        // var foo: (foo: Int) -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "Void", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (Int）-> Void\n")

//        // var foo: (foo: Int) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (Int）-> String\n")

//        // var foo: (_ foo: [([Bool],[Int])]) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [([", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "], [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: "])]) ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: ( [([Bool], [Int]）]） ->String\n")

//        // var foo: () -> [Bool]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " () -> [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (） -> [Bool]\n")

//        // var foo: () -> [[[String]]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " () -> [[[", finalOperators: "]]]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (） -> [[[String]]]\n")

//        // var foo: (_ foo: [Int: String]) -> (Int, String)
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "]) -> (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: ( [Int:String]） -> (Int, String）\n")

//        // var foo: Int { 3 }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "[readOnly]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: Int [readOnly]\n")

//        // var foo: [String] { [""] }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: [String] [readOnly]\n")

//        // var foo: [Bool:Bool] { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ":", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: ( [Bool:Bool]  ） [readOnly]\n")

        // var foo: (Bool,Int,String) { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")  [readOnly]")], kind: .property)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\t+ foo: (Bool, Int, String） [readOnly]\n")
        
        // var foo: (Bool,Int,String) { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [], kind: .lcase)
        XCTAssertEqual(mermaidParser.drawEntityProperties([property]), "\tfoo\n")
    }
    
    func testDrawEntityMethods() {
        // func foo()
        var method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() Void\n")
        
        // func foo(t: Int)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: Int"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo(t: Int) Void\n")
        
        // func foo(_ T: Int)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["T: Int"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(T: Int) Void")
        
        // func foo() -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() Bool\n")
        
        // func foo(b: Bool) -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["b: Bool"], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo(b: Bool) Bool\n")
        
        // func foo(bool: Bool, integer: Int, string: String) -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["bool: Bool", "integer: Int", "string: String"], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo(bool: Bool, integer: Int, string: String) Bool\n")
        
        // func foo(b: [Bool])
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["b: [Bool]"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo(b: [Bool]) Void\n")
        
        // func foo() -> [Int]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[", "Int", "]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() [ Int ]\n")
        
        // func foo() -> [[Int]]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[[", "Int", "]]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() [[ Int ]]\n")
        
        // func foo() -> (Int, String)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["(", "Int", ", ", "String", ")"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() ( Int ,  String ）\n")
        
        // func foo() -> [(Int, String)]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[(", "Int", ", ", "String", ")]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo() [( Int ,  String ）]\n")
        
        // func foo<T>(t: T)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo~T~(t: T) Void\n")
        
        // func foo<T, Q>(t: T, q: Q)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo~T, Q~(t: T, q: Q) Void\n")
        
        // func foo(_ f: [Int: String]) -> [Int: String]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["f: [Int : String]"], returns: ["[", "Int", " : ", "String", "]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(mermaidParser.drawEntityMethods([method]), "\t+ foo(f: [Int : String]) [ Int  :  String ]\n")
    
        
        // func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable
    }
    
    func testDrawEntityType() {
        XCTAssertEqual(mermaidParser.drawEntityType(.structure), "\t<<Structure>>")
        XCTAssertEqual(mermaidParser.drawEntityType(.enumeration), "\t<<Enumeration>>")
        XCTAssertEqual(mermaidParser.drawEntityType(.lprotocol), "\t<<Protocol>>")
        XCTAssertEqual(mermaidParser.drawEntityType(.lclass), "")
    }
    
    func testDrawRelationArrow() {
        XCTAssertEqual(mermaidParser.drawRelationArrow(.associatedTo, multiplicity: "foo 1"), "\"foo \"<--\" 1\"")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.associatedTo, multiplicity: "foo []"), "\"foo \"<--\" []\"")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.memberOf, multiplicity: ""), "*--")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.inheritsFrom, multiplicity: ""), "<|--")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.conformsTo, multiplicity: ""), "<|..")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.aggregatedTo, multiplicity: "foo 1"), "")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.extensionTo, multiplicity: ""), "")
        XCTAssertEqual(mermaidParser.drawRelationArrow(.requirementOf, multiplicity: ""), "")
    }
    
    func testParse() {
        let entity1 = Entity(name: "Foo", kind: .structure, generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        let entity2 = Entity(name: "Bar", kind: .structure, generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "T")])!)))
        
        let fooFoo = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        let barFoo = Property(accessLevel: .lpublic, name: "bar", types: [PropertyType(identifier: "Int", initialOperators: "[", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: "]")], kind: .property)
        let foobarFoo = Property(accessLevel: .lpublic, name: "foobar", types: [PropertyType(identifier: "Bool", initialOperators: "() ->", finalOperators: "")], kind: .property)
        let tBar = Property(accessLevel: .lpublic, name: "t", types: [PropertyType(identifier: "T", initialOperators: "", finalOperators: "")], kind: .property)
        
        entity1.properties[fooFoo.name] = fooFoo
        entity1.properties[barFoo.name] = barFoo
        entity1.properties[foobarFoo.name] = foobarFoo
        entity2.properties[tBar.name] = tBar
        
        let foofFoo = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foof", kind: "Instance Method", parameters: [], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        
        entity1.methods[foofFoo.name] = foofFoo
        
        let classDiagram = """
classDiagram
class `Foo`  {
    <<Structure>>
    + bar: ([Int:String]）
    + foo: Int
    + foobar: (）-> Bool

    + foof() Void

}
class `Bar` ~T: Equatable~ {
    <<Structure>>
    + t: T


} 
"""
        
        XCTAssertEqual(mermaidParser.parse(entities: [entity1, entity2]), classDiagram)
    }

}
