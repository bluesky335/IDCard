# IDCard [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) 

A swift package for verify China ID card number

---

[中文](README.md) | English

China National Standard：

- **Standard Number：GB 11643-1999**：[公民身份证号码](http://openstd.samr.gov.cn/bzgk/gb/newGbInfo?hcno=080D6FBF2BB468F9007657F26D60013E)

## Install

**Cocoapods**

```ruby
pod 'IDCard', '~> 1.0'
```

**Swift Package Manager**

```swift
dependencies: [
    .package(url: "https://github.com/bluesky335/IDCard.git", .upToNextMajor(from: "1.0"))
]
```

## Usage

### Verify
```swift
let card = IDCard(number:"11010519491231002X")
if card.isValid {
    print("✅:\(card.birthday.date)-\(card.birthday.year)-\(card.birthday.month)-\(card.birthday.day),\(card.gender)")
}else{
    print("❌")
}
```

### Create a ID number

```swift
// 2020-04-07 15:52:52
let date = Date(timeIntervalSince1970: 1586245972)
let formater = DateFormatter()
formater.timeZone = .init(secondsFromGMT: 8 * 60 * 60)
let cardNumber1 = IDCard.createIDCardNumber(birthday: date, dateFormater: formater)

let cardNumber2 = IDCard.createIDCardNumber(gender: .female)

let cardNumber3 = IDCard.createIDCardNumber(cityCode: "500232")
```


## golang version

[IDCheck](https://github.com/bluesky335/IDCheck)

