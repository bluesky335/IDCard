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

    func testCreateIDCardBirthday() {
        // 2020-04-07 15:52:52
        let date = Date(timeIntervalSince1970: 1586245972)
        let formater = DateFormatter()
        formater.timeZone = .init(secondsFromGMT: 8 * 60 * 60)
        let number2 = IDCard.createIDCardNumber(birthday: date, dateFormater: formater)
        let birthday = IDCard(number: number2).birthday
        XCTAssertEqual(IDCard.Birthday(year: "2020", month: "04", day: "07"), birthday)
    }

    func testCreateIDCardGender() {
        let number1 = IDCard.createIDCardNumber(gender: .female)
        XCTAssertEqual(IDCard(number: number1).gender, .female)
        let number2 = IDCard.createIDCardNumber(gender: .male)
        XCTAssertEqual(IDCard(number: number2).gender, .male)
    }

    func testCreateIDCardCityCode() {
        let number1 = IDCard.createIDCardNumber(cityCode: "500232")
        XCTAssertEqual(IDCard(number: number1).cityCode, "500232")
    }

    func testCard(cardnumber: String, birthDay: IDCard.Birthday, gender: IDCard.Gender) {
        let card = IDCard(number: cardnumber)
        XCTAssertTrue(card.isValid)
        XCTAssertEqual(card.gender, gender)
        XCTAssertEqual(card.birthday, birthDay)
    }
}
