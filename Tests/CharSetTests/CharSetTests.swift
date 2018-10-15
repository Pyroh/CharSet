import XCTest
@testable import CharSet

final class CharSetTests: XCTestCase {
    func testOperator() {
        XCTAssert("e" ?= CharSet.lowercaseLetters)
        XCTAssert("E" ?!= CharSet.lowercaseLetters)
    }
}
