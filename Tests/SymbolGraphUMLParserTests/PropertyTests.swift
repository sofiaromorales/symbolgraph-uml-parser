//
//  PropertyTests.swift
//  
//
//  Created by Sofia Rodriguez Morales on 2/5/23.
//

import XCTest
@testable import SymbolGraphUMLParser

class PropertyTests: XCTestCase {

    func testTextType() {
        
        // var foo = 1
        var property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "Int")
        
        // var foo = ""
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "String")
        
        // var foo: [Int] = []
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.textType, "[Int]")
        
        // var foo: [[String]] = [[]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: "[[", finalOperators: "]]")], kind: .property)
        XCTAssertEqual(property.textType, "[[String]]")
        
        // var foo: (Int, String, Bool, Int) = ()
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(property.textType, "(Int, String, Bool, Int)")
        
        // var foo: [String: String] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: "[", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.textType, "([String:String])")
        
        // var foo: [Int: (Bool, Int)] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ": (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")]")], kind: .property)
        XCTAssertEqual(property.textType, "( [Int:(Bool, Int)])")
        
        // var foo: Int?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "?")], kind: .property)
        XCTAssertEqual(property.textType, "Int?")
        
        // var foo: [Int]?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]?")], kind: .property)
        XCTAssertEqual(property.textType, "[Int]?")
        
        // var foo: [Int?]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "?]")], kind: .property)
        XCTAssertEqual(property.textType, "[Int?]")
        
        // var foo: P
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "P", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "P")
        
        // var foo: T
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "T", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "T")
        
        // var foo: () -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Void", initialOperators: " () ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "()-> Void")
        
        // var foo: (foo: Int) -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "Void", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "(Int)-> Void")
        
        // var foo: (foo: Int) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "(Int)-> String")
        
        // var foo: (_ foo: [([Bool],[Int])]) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [([", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "], [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: "])]) ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.textType, "( [([Bool], [Int])]) ->String")
        
        // var foo: () -> [Bool]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " () -> [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.textType, "() -> [Bool]")
        
        // var foo: () -> [[[String]]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " () -> [[[", finalOperators: "]]]")], kind: .property)
        XCTAssertEqual(property.textType, "() -> [[[String]]]")
        
        // var foo: (_ foo: [Int: String]) -> (Int, String)
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "]) -> (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(property.textType, "( [Int:String]) -> (Int, String)")
        
        // var foo: Int { 3 }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "[readOnly]")], kind: .property)
        XCTAssertEqual(property.textType, "Int [readOnly]")
        
        // var foo: [String] { [""] }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(property.textType, "[String]  [readOnly]")
        
        // var foo: [Bool:Bool] { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ":", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(property.textType, "( [Bool:Bool]  [readOnly])")
        
        // var foo: (Bool,Int,String) { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")  [readOnly]")], kind: .property)
        XCTAssertEqual(property.textType, "(Bool, Int, String) [readOnly]")
        
    }
    
    func testSignature() {
        
        // var foo = 1
        var property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: Int")
        
        // var foo = ""
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: String")
        
        // var foo: [Int] = []
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: [Int]")
        
        // var foo: [[String]] = [[]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [[", finalOperators: "]]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: [[String]]")
        
        // var foo: (Int, String, Bool, Int) = ()
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(property.signature, "foo: (Int, String, Bool, Int)")
        
        // var foo: [String: String] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ( [String:String])")
        
        // var foo: [Int: (Bool, Int)] = [:]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ": (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ")]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ( [Int:(Bool, Int)])")
        
        // var foo: Int?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "?")], kind: .property)
        XCTAssertEqual(property.signature, "foo: Int?")
        
        // var foo: [Int]?
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]?")], kind: .property)
        XCTAssertEqual(property.signature, "foo: [Int]?")
        
        // var foo: [Int?]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "?]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: [Int?]")
        
        // var foo: P
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "P", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: P")
        
        // var foo: T
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "T", initialOperators: "", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: T")
        
        // var foo: () -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Void", initialOperators: " () ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ()-> Void")
        
        // var foo: (foo: Int) -> Void
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "Void", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: (Int)-> Void")
        
        // var foo: (foo: Int) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ") ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: (Int)-> String")
        
        // var foo: (_ foo: [([Bool],[Int])]) -> String
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [([", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "], [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: "])]) ->", finalOperators: "")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ( [([Bool], [Int])]) ->String")
        
        // var foo: () -> [Bool]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " () -> [", finalOperators: "]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: () -> [Bool]")
        
        // var foo: () -> [[[String]]]
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " () -> [[[", finalOperators: "]]]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: () -> [[[String]]]")
        
        // var foo: (_ foo: [Int: String]) -> (Int, String)
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ":", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: "]) -> (", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ( [Int:String]) -> (Int, String)")
        
        // var foo: Int { 3 }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "[readOnly]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: Int [readOnly]")
        
        // var foo: [String] { [""] }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "String", initialOperators: " [", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: [String] [readOnly]")
        
        // var foo: [Bool:Bool] { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " [", finalOperators: ""), PropertyType(identifier: "Bool", initialOperators: ":", finalOperators: "]  [readOnly]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: ( [Bool:Bool]  ) [readOnly]")
        
        // var foo: (Bool,Int,String) { get }
        property = Property(accessLevel: .lpublic, name: "foo", types: [PropertyType(identifier: "Bool", initialOperators: " (", finalOperators: ""), PropertyType(identifier: "Int", initialOperators: ",", finalOperators: ""), PropertyType(identifier: "String", initialOperators: ",", finalOperators: ")  [readOnly]")], kind: .property)
        XCTAssertEqual(property.signature, "foo: (Bool, Int, String) [readOnly]")
    }

}
