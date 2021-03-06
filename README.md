# IDCard [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) 
Swift实现的中国居民身份证号码校验工具，检查其是否符合国家标准。

---

中文 | [English](README-en.md)

计算规则参考国家标准文件：

- **标准号：GB 11643-1999**：[公民身份证号码](http://openstd.samr.gov.cn/bzgk/gb/newGbInfo?hcno=080D6FBF2BB468F9007657F26D60013E)

## 安装

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

## 用法

```swift
let card = IDCard(number:"11010519491231002X")
if card.isValid {
    print("✅:\(card.birthday.date)-\(card.birthday.year)-\(card.birthday.month)-\(card.birthday.day),\(card.gender)")
}else{
    print("❌")
}
```

## go语言版本

[IDCheck](https://github.com/bluesky335/IDCheck)

