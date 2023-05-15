//
//  SymbolFactoryTests.swift
//  
//
//  Created by Sofia Rodriguez Morales on 29/4/23.
//

import XCTest
@testable import SymbolGraphUMLParser

class SymbolFactoryTests: XCTestCase { //59

    let symbolFactory = SymbolFactory()
    
    func testCreateEntity() {

        // Class `class Baz {}`
        var symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)],
            kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"),
            pathComponents: [],
            names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)])
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Baz", kind: .lclass, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Structure `struct Foo {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"),
            pathComponents: ["Foo"],
            names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)])
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Foo", kind: .structure, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Protocol `protocol Bar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BarP",interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Protocol", identifier: "protocol"),
            pathComponents: ["Bar"],
            names: SymbolDTO.Names(title: "Bar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)])
        )

        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Bar", kind: .lprotocol, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Enumeration `enum FooBar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo6FooBarO", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Enumeration", identifier: "enum"),
            pathComponents: ["FooBar"],
            names: SymbolDTO.Names(title: "FooBar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)])
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "FooBar", kind: .enumeration, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Class with protocol conformance `class Baz: Bar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class",preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazC", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"),
            pathComponents: ["Baz"],
            names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)])
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Baz", kind: .lclass, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Structure with protocol conformance `struct Foo: Bar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"),
            pathComponents: ["Foo"],
            names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)])
        )

        // Enumeration with protocol conformance `enum FooBar: Bar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo6FooBarO", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Enumeration", identifier: "enum"),
            pathComponents: ["FooBar"],
            names: SymbolDTO.Names(title: "FooBar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)])
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "FooBar", kind: .enumeration, generics: SwiftGenericDTO(parameters: [], constraints: []))
        )
        
        // Class with generic `class Baz<T> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"),
            pathComponents: ["Baz"],
            names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Baz", kind: .lclass, generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: []))
        )
        
        // Structure with generic `struct Foo: Bar {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"),
            pathComponents: ["Foo"],
            names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "Foo", kind: .structure, generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: []))
        )
        
        // Enumeration with generic `enum FooBar<T> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo6FooBarO", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Enumeration", identifier: "enum"),
            accessLevel: "public",
            pathComponents: ["FooBar"],
            names: SymbolDTO.Names(title: "FooBar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(name: "FooBar", kind: .enumeration, generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: []))
        )
        
        // Class with generic `class Baz<T: Bar> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP"))],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"), accessLevel: "public", pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(
                name: "Baz",
                kind: .lclass,
                generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")]))
        )
        
        // Structure with generic `struct Baz<T: Bar> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP"))],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"),
            pathComponents: ["Foo"],
            names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(
                name: "Foo",
                kind: .structure,
                generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")]))
        )
        
        // Enumeration with generic `enum FooBar<T: Bar> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP"))],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo6FooBarO", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Enumeration", identifier: "enum"),
            accessLevel: "public",
            pathComponents: ["FooBar"],
            names: SymbolDTO.Names(title: "FooBar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
                symbolFactory.createEntity(symbolDTO: symbolDTO),
                Entity(
                    name: "FooBar",
                    kind: .enumeration,
                    generics: SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T")])
                )
        )
        
        // Class with generic `class Baz<T: Bar, Q: Equatable> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazC", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"),
            accessLevel: "public", pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]),
            swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "Q", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
                symbolFactory.createEntity(symbolDTO: symbolDTO),
                Entity(
                    name: "Baz",
                    kind: .lclass,
                    generics: SwiftGenericDTO(
                        parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)],
                        constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")])
                )
        )
        
        // Structure with generic `structure Foo<T: Bar, Q: Equatable> {}`
        symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"), accessLevel: "public", pathComponents: ["Foo"], names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "Q", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
                symbolFactory.createEntity(symbolDTO: symbolDTO),
                Entity(
                    name: "Foo",
                    kind: .structure,
                    generics: SwiftGenericDTO(
                        parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)],
                        constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")])
                )
        )
        
        // Enumeration with generic `enum FooBar<T: Bar, Q: Equatable> {}`
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bar", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3BarP")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Q", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo6FooBarO", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Enumeration", identifier: "enum"), accessLevel: "public", pathComponents: ["FooBar"], names: SymbolDTO.Names(title: "FooBar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "enum", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "FooBar", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "Q", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createEntity(symbolDTO: symbolDTO),
            Entity(
                name: "FooBar",
                kind: .enumeration,
                generics: SwiftGenericDTO(
                    parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "Q", index: 1, depth: 0)],
                    constraints: [SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Bar", lhs: "T"), SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "Q")])
            )
        )

    }
    
    func testCreateProperty() {
        
        // Integer - var integer: Int = 1
        var symbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "integer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV7integerSivp", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"),
            accessLevel: "public",
            pathComponents: ["Foo", "integer"],
            names: SymbolDTO.Names(title: "integer", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "integer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]),
            swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(accessLevel: .lpublic, name: "integer", types: [PropertyType(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        )
        
        // String - var string: String = "Hello"
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "string", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6stringSSvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "string"], names: SymbolDTO.Names(title: "string", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "string", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))]), swiftGenerics: nil)
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(accessLevel: .lpublic, name: "string", types: [PropertyType(identifier: "String", initialOperators: "", finalOperators: "")], kind: .property)
        )
        
        // Boolean - var bool: Bool = true
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb"))], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV4boolSbvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "bool"], names: SymbolDTO.Names(title: "bool", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb"))]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(accessLevel: .lpublic, name: "bool", types: [PropertyType(identifier: "Bool", initialOperators: "", finalOperators: "")], kind: .property)
        )
        
        // Tuple - tuple: (Int, String, Bool) = (1, "Hello", true)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV5tupleSi_SSSbtvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "tuple"], names: SymbolDTO.Names(title: "tuple", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "tuple",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " (", finalOperators: ""),
                    PropertyType(identifier: "String", initialOperators: ",", finalOperators: ""),
                    PropertyType(identifier: "Bool", initialOperators: ",", finalOperators: ")")
                ],
                kind: .property
            )
        )
        
        // Array of Int - arrayInt: [Int] = [1, 2, 3]
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "arrayInt", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV8arrayIntSaySiGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "arrayInt"], names: SymbolDTO.Names(title: "arrayInt", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "arrayInt", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "arrayInt",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]")
                ],
                kind: .property
            )
        )
        
        // Array of Bool - arrayInt: [Bool] = [true, false]
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "arrayBool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV9arrayBoolSaySbGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "arrayBool"], names: SymbolDTO.Names(title: "arrayBool", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "arrayBool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "arrayBool",
                types: [
                    PropertyType(identifier: "Bool", initialOperators: " [", finalOperators: "]")
                ],
                kind: .property
            )
        )
        
        // Anon function - ((_ text: String) -> Int)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "anonFunction", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ((", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV12anonFunctionySiSScvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "anonFunction"], names: SymbolDTO.Names(title: "anonFunction", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "anonFunction", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ((", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "anonFunction",
                types: [
                    PropertyType(identifier: "String", initialOperators: "", finalOperators: ""),
                    PropertyType(identifier: "Int", initialOperators: ") ->", finalOperators: ")")
                ],
                kind: .property
            )
        )
        
        // Anon function - anonFunctionMultipleParams: ((_ text: String, _ int: Int) -> Void)
        symbolDTO = SymbolDTO(
            declarationFragments: [
                SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "identifier", spelling: "anonFunctionMultipleParams", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: ": ((", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "internalParam", spelling: "text", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")),
                SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "internalParam", spelling: "int", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")),
                SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil),
                SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Void", preciseIdentifier: Optional("s:s4Voida")),
                SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)
            ],
            functionSignature: nil,
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV26anonFunctionMultipleParamsyySS_Sitcvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"),
            accessLevel: "public",
            pathComponents: ["Foo", "anonFunctionMultipleParams"],
            names: SymbolDTO.Names(title: "anonFunctionMultipleParams", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "anonFunctionMultipleParams", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ((", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Void", preciseIdentifier: Optional("s:s4Voida")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]),
            swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "anonFunctionMultipleParams",
                types: [
                    PropertyType(identifier: "String", initialOperators: "", finalOperators: ""),
                    PropertyType(identifier: "Int", initialOperators: ":", finalOperators: ""),
                    PropertyType(identifier: "Void", initialOperators: ") ->", finalOperators: ")")
                ],
                kind: .property
            )
        )
        
        // Anon function - anonFunctionWithEmbedFunction: ((() -> Int) -> Void)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "anonFunctionWithEmbedFunction", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ((() -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Void", preciseIdentifier: Optional("s:s4Voida")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV021anonFunctionWithEmbedG0yySiyXEcvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "anonFunctionWithEmbedFunction"], names: SymbolDTO.Names(title: "anonFunctionWithEmbedFunction", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "anonFunctionWithEmbedFunction", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ((() -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Void", preciseIdentifier: Optional("s:s4Voida")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "anonFunctionWithEmbedFunction",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " ((() ->", finalOperators: ""),
                    PropertyType(identifier: "Void", initialOperators: ") ->", finalOperators: ")")
                ],
                kind: .property
            )
        )
        
        // Generic - var t = [T]()
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV1tSayxGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "t"], names: SymbolDTO.Names(title: "t", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "t",
                types: [
                    PropertyType(identifier: "T", initialOperators: " [", finalOperators: "]")
                ],
                kind: .property
            )
        )
        
        // Generic -  var integer: [Int] = []
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "integer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV7integerSaySiGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "integer"], names: SymbolDTO.Names(title: "integer", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "integer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil)
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "integer",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]")
                ],
                kind: .property
            )
        )
        
        // Tuple array - var tupleArray: [(Int, Bool)] = []
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "tupleArray", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")]", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV10tupleArraySaySi_SbtGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "tupleArray"], names: SymbolDTO.Names(title: "tupleArray", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "tupleArray", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")]", preciseIdentifier: nil)]), swiftGenerics: nil)
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "tupleArray",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " [(", finalOperators: ""),
                    PropertyType(identifier: "Bool", initialOperators: ",", finalOperators: ")]")
                ],
                kind: .property
            )
        )
        
        // var count: [Int] { get }
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "count", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "] { ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "get", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " }", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo9ContainerP5countSaySiGvp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Container", "count"], names: SymbolDTO.Names(title: "count", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "count", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil)
        XCTAssertEqual(
            symbolFactory.createProperty(symbolDTO: symbolDTO),
            Property(
                accessLevel: .lpublic,
                name: "count",
                types: [
                    PropertyType(identifier: "Int", initialOperators: " [", finalOperators: "]  [readOnly]")
                ],
                kind: .property
            )
        )

    }
    
    func testCreateMethod() {
        
        // foo()
        var symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3fooyyF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foo()"], names: SymbolDTO.Names(title: "foo()", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foo",
                kind: SymbolType.method.rawValue,
                parameters: [],
                returns: ["Void"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // bar(text: String)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "text", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bar4textySS_tF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "bar(text:)"], names: SymbolDTO.Names(title: "bar(text:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "bar",
                kind: SymbolType.method.rawValue,
                parameters: ["text: String"],
                returns: ["Void"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // baz(_ text: String)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "text", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "text", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bazyySSF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "baz(_:)"], names: SymbolDTO.Names(title: "baz(_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "baz",
                kind: SymbolType.method.rawValue,
                parameters: ["text: String"],
                returns: ["Void"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foobar() -> Int
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "() -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]), parameters: Optional([]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6foobarSiyF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foobar()"], names: SymbolDTO.Names(title: "foobar()", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "() -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foobar",
                kind: SymbolType.method.rawValue,
                parameters: [],
                returns: ["Int"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foobaz(int: Int) -> Int
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "int", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6foobaz3intS2i_tF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foobaz(int:)"], names: SymbolDTO.Names(title: "foobaz(int:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foobaz",
                kind: SymbolType.method.rawValue,
                parameters: ["int: Int"],
                returns: ["Int"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foo(_ int: [Int], _ bool: Bool) -> String
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "], ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "bool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "int", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "int", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "bool", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "bool", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3fooySSSaySiG_SbtF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foo(_:_:)"], names: SymbolDTO.Names(title: "foo(_:_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "([", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: "], ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS"))]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foo",
                kind: SymbolType.method.rawValue,
                parameters: ["int: [Int]", "bool: Bool"],
                returns: ["String"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // bar(tuple: (Int, String, Bool, (Bool, Bool)))
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")))", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "tuple", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "))", preciseIdentifier: nil)])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bar5tupleySi_SSS2b_Sbtt_tF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "bar(tuple:)"], names: SymbolDTO.Names(title: "bar(tuple:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ")))", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "bar",
                kind: SymbolType.method.rawValue,
                parameters: ["tuple: (Int, String, Bool, (Bool, Bool))"],
                returns: ["Void"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // baz(_ tuple: (Int, String, Bool, (Bool, Bool))) -> (Int, String)
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "))) -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "tuple", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "tuple", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "))", preciseIdentifier: nil)])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bazySi_SStSi_SSS2b_Sbtt_tF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "baz(_:)"], names: SymbolDTO.Names(title: "baz(_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "((", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "))) -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "String", preciseIdentifier: Optional("s:SS")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "baz",
                kind: SymbolType.method.rawValue,
                parameters: ["tuple: (Int, String, Bool, (Bool, Bool))"],
                returns: ["(", "Int", ", ", "String", ")"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foobar(_ array: [(Bool, Int)]) -> [Bool]
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "array", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ")]) -> [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "[", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "array", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "array", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": [(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ")]", preciseIdentifier: nil)])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6foobarySaySbGSaySb_SitGF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foobar(_:)"], names: SymbolDTO.Names(title: "foobar(_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "([(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si")), SymbolDTO.Construct(kind: "text", spelling: ")]) -> [", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: "]", preciseIdentifier: nil)]), swiftGenerics: nil
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foobar",
                kind: SymbolType.method.rawValue,
                parameters: ["array: [(Bool, Int)]"],
                returns: ["[", "Bool", "]"],
                generics: Optional(SwiftGenericDTO(parameters: [], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foo<T>(_ t: T) {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3fooyyxlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "t", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3fooyyxlF1TL_xmfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3fooyyxlF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foo(_:)"], names: SymbolDTO.Names(title: "foo(_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3fooyyxlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foo",
                kind: SymbolType.method.rawValue,
                parameters: ["t: T"],
                returns: ["Void"],
                generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // bar<T>(t T: T) -> T {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF1TL_xmfp"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "t", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF1TL_xmfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "bar(t:)"], names: SymbolDTO.Names(title: "bar(t:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bar1txx_tlF1TL_xmfp"))]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "bar",
                kind: SymbolType.method.rawValue,
                parameters: ["T: T"],
                returns: ["T"],
                generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // baz<T: Equatable>(_ T: T) -> T {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "T", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF1TL_xmfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "baz(_:)"], names: SymbolDTO.Names(title: "baz(_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "baz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV3bazyxxSQRzlF1TL_xmfp"))]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "T")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "baz",
                kind: SymbolType.method.rawValue,
                parameters: ["T: T"],
                returns: ["T"],
                generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "T")]) as! [SwiftGenericDTO.Constraint]))
            )
        )
        
        // foobar<T, P>(t T: T, p P: P) -> (T, P) {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "t", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1TL_xmfp"))]), SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "p", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1PL_q_mfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foobar(t:p:)"], names: SymbolDTO.Names(title: "foobar(t:p:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobar1t1px_q_tx_q_tr0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: nil, parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "P", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foobar",
                kind: SymbolType.method.rawValue,
                parameters: ["T: T", "P: P"],
                returns:  ["(", "T", ", ", "P", ")"],
                generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "P", index: 1, depth: 0)], constraints: Optional([]) as! [SwiftGenericDTO.Constraint] ))
            )
        )
        
        // foobaz<T, P>(t T: T, p P: P) -> (T, P) where P: Equatable {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "t", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1TL_xmfp"))]), SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "p", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1PL_q_mfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foobaz(t:p:)"], names: SymbolDTO.Names(title: "foobaz(t:p:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foobaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6foobaz1t1px_q_tx_q_tSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "P")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "P", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "foobaz",
                kind: SymbolType.method.rawValue,
                parameters: ["T: T", "P: P"],
                returns: ["(", "T", ", ", "P", ")"],
                generics: Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "P", index: 1, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "P")])!))
            )
        )
        
        // barbaz<T, P>(t T: T, p P: P) -> (T, P) where P: Equatable, T: Collection
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "barbaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Collection", preciseIdentifier: Optional("s:Sl")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ"))], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "t", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1TL_xmfp"))]), SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "p", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1PL_q_mfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "barbaz(t:p:)"], names: SymbolDTO.Names(title: "barbaz(t:p:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "barbaz", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "T", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "P", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "t", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "p", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> (", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "T", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1TL_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "P", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV6barbaz1t1px_q_tx_q_tSlRzSQR_r0_lF1PL_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ")", preciseIdentifier: nil)]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Collection", lhs: "T"), SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "P")]), parameters: Optional([SymbolDTO.Parameter(name: "T", index: 0, depth: 0), SymbolDTO.Parameter(name: "P", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "barbaz",
                kind: SymbolType.method.rawValue,
                parameters: ["T: T", "P: P"],
                returns: ["(", "T", ", ", "P", ")"],
                generics:  Optional(SwiftGenericDTO(parameters: [SwiftGenericDTO.Parameter(name: "T", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "P", index: 1, depth: 0)], constraints: Optional([SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Collection", lhs: "T"), SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "P")])!))
            )
        )
        
        // allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {}
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "allItemsMatch", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "C1", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "C2", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "someContainer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C1L_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "externalParam", spelling: "_", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "internalParam", spelling: "anotherContainer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C2", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C2L_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb")), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "keyword", spelling: "where", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Container", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo9ContainerP")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C2", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Container", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo9ContainerP")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ".", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Item", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " : ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Equatable", preciseIdentifier: Optional("s:SQ")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ".", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Item", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " == ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C2", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ".", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Item", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb"))]), parameters: Optional([SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "someContainer", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "someContainer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C1L_xmfp"))]), SymbolDTO.FunctionSignature.FunctionSignatureParameter(name: "anotherContainer", declarationFragments: [SymbolDTO.Construct(kind: "identifier", spelling: "anotherContainer", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C2", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C2L_q_mfp"))])]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "allItemsMatch(_:_:)"], names: SymbolDTO.Names(title: "allItemsMatch(_:_:)", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "allItemsMatch", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "<", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "C1", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "genericParameter", spelling: "C2", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ">(", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C1", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C1L_xmfp")), SymbolDTO.Construct(kind: "text", spelling: ", ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "C2", preciseIdentifier: Optional("s:24SymbolGraphUMLParserDemo3FooV13allItemsMatchySbx_q_tAA9ContainerRzAaER_SQ4ItemRpzAFQy_AGRSr0_lF2C2L_q_mfp")), SymbolDTO.Construct(kind: "text", spelling: ") -> ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Bool", preciseIdentifier: Optional("s:Sb"))]), swiftGenerics: Optional(SymbolDTO.SwiftGenericDTO(constraints: Optional([SymbolDTO.Constraint(kind: "conformance", rhs: "Container", lhs: "C1"), SymbolDTO.Constraint(kind: "conformance", rhs: "Container", lhs: "C2"), SymbolDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "C1.Item"), SymbolDTO.Constraint(kind: "sameType", rhs: "C2.Item", lhs: "C1.Item")]), parameters: Optional([SymbolDTO.Parameter(name: "C1", index: 0, depth: 0), SymbolDTO.Parameter(name: "C2", index: 1, depth: 0)])))
        )
        XCTAssertEqual(
            symbolFactory.createMethod(symbolDTO: symbolDTO),
            Method(
                accessLevel: .lpublic,
                type: .method,
                name: "allItemsMatch",
                kind: SymbolType.method.rawValue,
                parameters: ["someContainer: C1", "anotherContainer: C2"],
                returns: ["Bool"],
                generics: Optional(SwiftGenericDTO(
                    parameters: [SwiftGenericDTO.Parameter(name: "C1", index: 0, depth: 0), SwiftGenericDTO.Parameter(name: "C2", index: 1, depth: 0)],
                    constraints: Optional([
                        SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Container", lhs: "C1"),
                        SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Container", lhs: "C2"),
                        SwiftGenericDTO.Constraint(kind: "conformance", rhs: "Equatable", lhs: "C1.Item"),
                        SwiftGenericDTO.Constraint(kind: "sameType", rhs: "C2.Item", lhs: "C1.Item")
                    ])!
                ))
            )
        )

    }
    
    func testAssignRelationship() {
        
        // Test Set Up
        var graph = SymbolGraphModel(entities: [:], properties: [:], methods: [:])
        let entitySymbolDTO = SymbolDTO(
            declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)],
            identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV", interfaceLanguage: "swift"),
            kind: SymbolDTO.Kind(displayName: "Structure", identifier: "struct"),
            pathComponents: ["Foo"],
            names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "struct", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)])
        )
        graph.entities[entitySymbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: entitySymbolDTO)

        // Property relations
        let propertySymbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))], identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3barSivp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), pathComponents: ["Foo", "bar"], names: SymbolDTO.Names(title: "bar", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "bar", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]))
        let property = symbolFactory.createProperty(symbolDTO: propertySymbolDTO)
        graph.properties[propertySymbolDTO.identifier.precise] = property
        symbolFactory.assignRelationship(symbolDTO: propertySymbolDTO, relationType: "memberOf", parentSymbolID: entitySymbolDTO.identifier.precise, graph: &graph)
        XCTAssertTrue(graph.entities[entitySymbolDTO.identifier.precise]!.properties.contains { $0.value == property } )
        
        // Method relations
        let methodSymbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)], functionSignature: Optional(SymbolDTO.FunctionSignature(returns: Optional([SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]), parameters: Optional([]))), identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooV3fooyyF", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Method", identifier: "method"), accessLevel: "public", pathComponents: ["Foo", "foo()"], names: SymbolDTO.Names(title: "foo()", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "func", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "foo", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: "()", preciseIdentifier: nil)]))
        let method = symbolFactory.createMethod(symbolDTO: methodSymbolDTO)
        symbolFactory.assignRelationship(symbolDTO: propertySymbolDTO, relationType: "memberOf", parentSymbolID: entitySymbolDTO.identifier.precise, graph: &graph)
        graph.methods[methodSymbolDTO.identifier.precise] = method
        symbolFactory.assignRelationship(symbolDTO: methodSymbolDTO, relationType: "memberOf", parentSymbolID: entitySymbolDTO.identifier.precise, graph: &graph)
        XCTAssertTrue(graph.entities[entitySymbolDTO.identifier.precise]!.methods.contains { $0.value == method } )
        
        
    }
    
    func testAddEntityToEntityRelation() {
        
        // Test Set Up
        var graph = SymbolGraphModel(entities: [:], properties: [:], methods: [:])
        
        // 1
        var symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)], identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazP", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Protocol", identifier: "protocol"), pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]))
        graph.entities[symbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: symbolDTO)
        var parentSymbolDTO: SymbolDTO? = nil
        var relationType: String? = nil
        var relations = symbolFactory.addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        XCTAssertFalse(graph.entities.contains { $0.1.name == parentSymbolDTO?.names.title } )
        XCTAssertTrue(relations == nil)
        
        // 2
        graph.entities = [:]
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)], identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazP", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Protocol", identifier: "protocol"), pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]))
        graph.entities[symbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: symbolDTO)
        relationType = "conformsTo"
        parentSymbolDTO = Optional(SymbolDTO(location: Optional(SymbolDTO.Location(uri: "file:///Users/sofiarodriguezmorales/Desktop/personal-projects/SymbolGraphUMLParserDemo/Sources/SymbolGraphUMLParserDemo/SymbolGraphUMLParserDemo.swift", position: SymbolDTO.Location.Position(line: 0, character: 16))), declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazP", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Protocol", identifier: "protocol"), accessLevel: "public", pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), swiftGenerics: nil))
        relations = symbolFactory.addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        var parentEntity = symbolFactory.createEntity(symbolDTO: parentSymbolDTO!)
        XCTAssertTrue(graph.entities.contains { $0.1 == parentEntity } )
        XCTAssertTrue(relations != nil)
        XCTAssertTrue(relations!.contains { $0.0 == parentEntity } )
        
        // 3
        symbolDTO = SymbolDTO(functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BarC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"), accessLevel: "public", pathComponents: ["Bar"], names: SymbolDTO.Names(title: "Bar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)]), swiftGenerics: nil)
        parentSymbolDTO = Optional(SymbolDTO(functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BazP", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Protocol", identifier: "protocol"), accessLevel: "public", pathComponents: ["Baz"], names: SymbolDTO.Names(title: "Baz", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "protocol", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Baz", preciseIdentifier: nil)]), swiftGenerics: nil))
        relationType = Optional("conformsTo")
        graph.entities[symbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: symbolDTO)
        relations = symbolFactory.addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        parentEntity = symbolFactory.createEntity(symbolDTO: parentSymbolDTO!)
        XCTAssertTrue(graph.entities.contains { $0.1 == parentEntity } )
        XCTAssertTrue(relations != nil)
        XCTAssertTrue(relations!.contains { $0.0 == parentEntity } )
        
        // 4
        symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3BarC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"), accessLevel: "public", pathComponents: ["Bar"], names: SymbolDTO.Names(title: "Bar", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Bar", preciseIdentifier: nil)]), swiftGenerics: nil)
        relationType = Optional("inheritsFrom")
        parentSymbolDTO = Optional(SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"), accessLevel: "public", pathComponents: ["Foo"], names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), swiftGenerics: nil))
        graph.entities[symbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: symbolDTO)
        graph.entities[symbolDTO.identifier.precise] = symbolFactory.createEntity(symbolDTO: symbolDTO)
        relations = symbolFactory.addEntityToEntityRelation(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        parentEntity = symbolFactory.createEntity(symbolDTO: parentSymbolDTO!)
        XCTAssertTrue(graph.entities.contains { $0.1 == parentEntity } )
        XCTAssertTrue(relations != nil)
        XCTAssertTrue(relations!.contains { $0.0 == parentEntity } )
        
    }
    
    func testCreateSymbol() {
        var graph = SymbolGraphModel(entities: [:], properties: [:], methods: [:])
        
        let symbolDTO = SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "number", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooC6numberSivp", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Instance Property", identifier: "property"), accessLevel: "public", pathComponents: ["Foo", "number"], names: SymbolDTO.Names(title: "number", navigator: nil, subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "var", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "number", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: ": ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "typeIdentifier", spelling: "Int", preciseIdentifier: Optional("s:Si"))]), swiftGenerics: nil)
        let parentSymbolDTO = Optional(SymbolDTO(declarationFragments: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)], functionSignature: nil, identifier: SymbolDTO.Identifier(precise: "s:24SymbolGraphUMLParserDemo3FooC", interfaceLanguage: "swift"), kind: SymbolDTO.Kind(displayName: "Class", identifier: "class"), accessLevel: "public", pathComponents: ["Foo"], names: SymbolDTO.Names(title: "Foo", navigator: Optional([SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), subHeading: [SymbolDTO.Construct(kind: "keyword", spelling: "class", preciseIdentifier: nil), SymbolDTO.Construct(kind: "text", spelling: " ", preciseIdentifier: nil), SymbolDTO.Construct(kind: "identifier", spelling: "Foo", preciseIdentifier: nil)]), swiftGenerics: nil))
        var relationType = Optional("memberOf")
        symbolFactory.createSymbol(relationType: nil, graph: &graph, symbolDTO: parentSymbolDTO!, parentSymbolDTO: nil)
        symbolFactory.createSymbol(relationType: relationType, graph: &graph, symbolDTO: symbolDTO, parentSymbolDTO: parentSymbolDTO)
        XCTAssertTrue(graph.entities.contains { $0.0 == parentSymbolDTO?.identifier.precise } )
        XCTAssertTrue(graph.properties.contains { $0.0 == symbolDTO.identifier.precise } )
    }
    
}
