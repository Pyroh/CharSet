import XCTest
@testable import CharSet

final class CharSetTests: XCTestCase {
    func testOperator() {
        measure {
            XCTAssert("e" ?= CharSet.lowercaseLetters)
            XCTAssert("E" ?!= CharSet.lowercaseLetters)
        }
    }
    
    func testPerformances() {
        measure {
            print(CharSet.alphanumerics.count)
            _ = CharSet.alphanumerics.contains("1")
        }
    }
}
