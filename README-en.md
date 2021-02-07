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

```swift
let card = IDCard(number:"11010519491231002X")
if card.isValid {
    print("✅:\(card.birthday.date)-\(card.birthday.year)-\(card.birthday.month)-\(card.birthday.day),\(card.gender)")
}else{
    print("❌")
}
```


## golang version

[IDCheck](https://github.com/bluesky335/IDCheck)

