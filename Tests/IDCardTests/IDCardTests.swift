@testable import IDCard
import XCTest

final class IDCardTests: XCTestCase {
    func testIDCards() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        // 官方示例-女
        testCard(cardnumber: "11010519491231002X", birthDay: .init(year: "1949", month: "12", day: "31"), gender: .female)
        // 官方示例-男
        testCard(cardnumber: "440524188001010014", birthDay: .init(year: "1880", month: "01", day: "01"), gender: .male)
        let number = IDCard.createIDCardNumber()
        XCTAssertTrue(IDCard(number: number).isValid)
    }

    func testCard(cardnumber: String, birthDay: IDCard.Birthday, gender: IDCard.Gender) {
        let card = IDCard(number: cardnumber)
        XCTAssertTrue(card.isValid)
        XCTAssertEqual(card.gender, gender)
        XCTAssertEqual(card.birthday, birthDay)
    }
}
