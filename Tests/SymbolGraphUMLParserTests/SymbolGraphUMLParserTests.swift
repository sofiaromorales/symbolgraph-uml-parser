import XCTest
@testable import SymbolGraphUMLParser

func XCTAssertEqual(
  _ text: String,
  multiline reference: String,
  file: StaticString = #file,
  line: UInt = #line
) {
  let textLines = text.split(separator: "\n", omittingEmptySubsequences: false)
  let referenceLines = reference.split(separator: "\n", omittingEmptySubsequences: false)

  for idx in 0..<max(textLines.count, referenceLines.count) {
    let left = textLines[safely: idx]
    let right = referenceLines[safely: idx]
    let line = line + UInt(1 + idx)
    if let left = left, let right = right {
      XCTAssertEqual(left, right, file: file, line: line)
    } else {
      XCTAssertEqual(left, right, file: file, line: line)
    }
  }
}

final class SymbolGraphUMLParserTests: XCTestCase {
    
    var symbolGraphUMLParser: SymbolGraphUMLParser! = SymbolGraphUMLParser()
    var graph: SymbolGraphModel!
    
    override func setUp() {
        let entities: [String: Entity] = [
            "Foo" : Entity(name: "Foo", kind: .structure, generics: nil),
            "Bar" : Entity(name: "Bar", kind: .lprotocol, generics: nil)
        ]
        let properties: [String: Property] = [
            "fooProp" : Property(accessLevel: .lpublic, name: "fooProp", types: [], kind: .property),
            "barProps" : Property(accessLevel: .lpublic, name: "barProp", types: [.init(identifier: "Int", initialOperators: "", finalOperators: "")], kind: .property)
        ]
        let methods = [
            "fooMethod" : Method(
                accessLevel: .lpublic,
                type: .method,
                name: "fooMethod",
                kind: "",
                parameters: [],
                returns: []
            )
        ]
        entities["Foo"]?.properties = ["fooProp" : properties["fooProp"]!]
        entities["Foo"]?.methods = ["fooMethod" : methods["fooMethod"]!]
        entities["Bar"]?.properties = ["barProps" : properties["barProps"]!]
        entities["Foo"]?.relations = [.conformsTo : [(entities["Bar"]!, nil)]]
        graph = SymbolGraphModel(entities: entities, properties: properties, methods: methods)
        
        
     }
    
    func testEnumerateEntitiesWithProperties() {
        let graphTextualRepresentation = symbolGraphUMLParser.enumerateEntitiesWithProperties(graph)
        let assertGraphTextualRepresentation = """
|⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻|
| Bar - lprotocol |
|--------------------------------------|
| lpublic barProp : Int |
|---------------------------------------|
|---------------------------------------|
|_______________________________________|
***
|⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻|
| Foo - structure |
|--------------------------------------|
| lpublic fooProp :  |
|---------------------------------------|
| lpublic fooMethod [] -> [] |
|---------------------------------------|
| conformsTo ---> Bar |
|_______________________________________|
***\n
"""
        XCTAssertEqual(graphTextualRepresentation, multiline: assertGraphTextualRepresentation)
    }
}

private extension Array {
  subscript(safely index: Index) -> Element? {
    if self.indices.contains(index) {
      return self[index]
    } else {
      return nil
    }
  }
}
