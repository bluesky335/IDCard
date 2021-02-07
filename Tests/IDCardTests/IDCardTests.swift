import XCTest
@testable import IDCard

final class IDCardTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(IDCard().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
