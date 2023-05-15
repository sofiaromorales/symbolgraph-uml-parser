//
//  MethodTests.swift
//  
//
//  Created by Sofia Rodriguez Morales on 2/5/23.
//

import XCTest
@testable import SymbolGraphUMLParser

class MethodTests: XCTestCase { //21

    func testGenericsTextRepresentation() {
        
        // func foo()
        var method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.genericsTextRepresentation, "")
        
        // func foo<T>(t: T)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.genericsTextRepresentation, "~T~")
        
        // func foo<T: Equatable>(t: T)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "T")])!)))
        XCTAssertEqual(method.genericsTextRepresentation, "~T: Equatable~")
        
        // func foo<T, Q>(t: T, q: Q)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.genericsTextRepresentation, "~T, Q~")
        
        // func foo<T: P, Q: P>(t: T, q: Q)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "P", lhs: "T"), SwiftGenericDTO.Constraint(kind: "conformance", rhs: "P", lhs: "Q")])!)))
        XCTAssertEqual(method.genericsTextRepresentation, "~T: P, Q: P~")
        
        // func foo<T, Q>(t: T, q: Q) where T: P
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "P", lhs: "T")])!)))
        XCTAssertEqual(method.genericsTextRepresentation, "~T: P, Q~")
        
        // func foo<T, Q>(t: T, q: Q) where Q: P
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "P", lhs: "Q")])!)))
        XCTAssertEqual(method.genericsTextRepresentation, "~T, Q: P~")
        
        // func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable
        
    }
    
    func testSignature() {
        
        // func foo()
        var method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() Void")
        
        // func foo(t: Int)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: Int"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(t: Int) Void")
        
        // func foo(_ T: Int)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["T: Int"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(T: Int) Void")
        
        // func foo() -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() Bool")
        
        // func foo(b: Bool) -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["b: Bool"], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(b: Bool) Bool")
        
        // func foo(bool: Bool, integer: Int, string: String) -> Bool
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["bool: Bool", "integer: Int", "string: String"], returns: ["Bool"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(bool: Bool, integer: Int, string: String) Bool")
        
        // func foo(b: [Bool])
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["b: [Bool]"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(b: [Bool]) Void")
        
        // func foo() -> [Int]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[", "Int", "]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() [ Int ]")
        
        // func foo() -> [[Int]]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[[", "Int", "]]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() [[ Int ]]")
        
        // func foo() -> (Int, String)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["(", "Int", ", ", "String", ")"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() ( Int ,  String ）")
        
        // func foo() -> [(Int, String)]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: [], returns: ["[(", "Int", ", ", "String", ")]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo() [( Int ,  String ）]")
        
        // func foo<T>(t: T)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo~T~(t: T) Void")
        
        // func foo<T, Q>(t: T, q: Q)
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["t: T", "q: Q"], returns: ["Void"], generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo~T, Q~(t: T, q: Q) Void")
        
        // func foo(_ f: [Int: String]) -> [Int: String]
        method = Method(accessLevel: AccessLevelKinds.lpublic, type: SymbolType.method, name: "foo", kind: "Instance Method", parameters: ["f: [Int : String]"], returns: ["[", "Int", " : ", "String", "]"], generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint])))
        XCTAssertEqual(method.signature, "foo(f: [Int : String]) [ Int  :  String ]")
    
        
        // func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable
    }

}
