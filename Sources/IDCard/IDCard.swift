/*
 MIT License

 Copyright (c) 2021 CoderX

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

 */
// Author: @BlueSky335 github home page : https://github.com/bluesky335/IDCard
//
//  IDCard.swift
//  IDCard
//
//  Created by @BlueSky335 on 2021/2/7.
//

import Foundation

/// 中国居民身份证号
public class IDCard {
    public enum Gender: Int {
        case male
        case female
    }

    public struct Birthday: Equatable {
        public let year: String
        public let month: String
        public let day: String

        public var date: Date {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            return formater.date(from: "\(year)-\(month)-\(day)") ?? Date(timeIntervalSince1970: 0)
        }

        public init(year: String, month: String, day: String) {
            self.year = year
            self.month = month
            self.day = day
        }
    }

    /// 身份证号码
    public let numbers: String

    /// 生日
    public private(set) lazy var birthday: Birthday = getBirthday()

    /// 性别
    public private(set) lazy var gender: Gender = getGender()

    /// 是否符合国标
    public private(set) lazy var isValid: Bool = checkIDCard()
    
    /// 区域代码，身份证前6位
    public private(set) lazy var cityCode: String = getCityCode()

    /// 初始化
    /// - Parameter number: 身份证号码
    public init(number: String) {
        numbers = number.uppercased()
    }

    public class func createIDCardNumber(cityCode: String? = nil, gender: Gender? = nil, birthday: Date? = nil, dateFormater: DateFormatter? = nil) -> String {
        var cityStr = cityCode ?? cityCodeList.randomElement() ?? "110105"
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{6}$")
        if !predicate.evaluate(with: cityStr) {
            cityStr = "110105"
        }
        var randomNumber = Int.random(in: 100 ... 998)
        if let g = gender {
            switch g {
            case .female:
                if randomNumber % 2 != 0 {
                    randomNumber += 1
                }
            case .male:
                if randomNumber % 2 == 0 {
                    randomNumber += 1
                }
            }
        }
        let randomStr = "\(randomNumber)"
        let formater = dateFormater ?? DateFormatter()
        formater.dateFormat = "yyyyMMdd"
        let dateIntervel = Date().timeIntervalSince1970 - TimeInterval.random(in: 0 ... 1) * (70.0 * 365.0 * 24.0 * 60.0 * 60.0)
        let birthdayDate = birthday ?? Date(timeIntervalSince1970: dateIntervel)
        let birthDayStr = formater.string(from: birthdayDate)
        var cardStr = cityStr + birthDayStr + randomStr
        let signChar = getSignChar(for: cardStr + "0")
        cardStr += signChar ?? "0"
        return cardStr
    }

    private static func getSignChar(for numbers: String) -> String? {
        let a1Map: [Int: Int] = [
            0: 1,
            1: 0,
            2: 10,
            3: 9,
            4: 8,
            5: 7,
            6: 6,
            7: 5,
            8: 4,
            9: 3,
            10: 2,
        ]

        let idStr = numbers.uppercased()
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{17}[0-9X]$")
        guard predicate.evaluate(with: idStr) else {
            return nil
        }

        var sum: Int = 0
        for (index, c) in idStr.enumerated() {
            let i = 18 - index
            if index != 17 {
                guard let v = Int(String(c)) else {
                    return nil
                }
                let weight = Int(pow(2, Float(i - 1))) % 11

                sum += v * weight
            }
        }
        guard let a1 = a1Map[sum % 11] else {
            return nil
        }

        var a1Str = "\(a1)"
        if a1 == 10 {
            a1Str = "X"
        }
        return a1Str
    }

    /// 获取身份证号码
    /// - Returns: 生日，如果是不符合规范的身份证，则返回时间戳为0的时间
    private func getBirthday() -> Birthday {
        guard isValid else {
            return Birthday(year: "", month: "", day: "")
        }
        let year = numbers[6 ..< 10]
        let month = numbers[10 ..< 12]
        let day = numbers[12 ..< 14]
        return Birthday(year: String(year), month: String(month), day: String(day))
    }

    // 检查是否符合身份证国标
    // 计算规则参考“中国国家标准化管理委员会”官方文档：http://www.gb688.cn/bzgk/gb/newGbInfo?hcno=080D6FBF2BB468F9007657F26D60013E
    /// - Returns: 是否符合国标要求
    private func checkIDCard() -> Bool {
        guard let a1Str = Self.getSignChar(for: numbers) else {
            // 不符合身份证规则
            return false
        }
        let signChar = String(numbers[numbers.index(numbers.startIndex, offsetBy: 17)])
        guard a1Str == signChar else {
            return false
        }
        return true
    }

    /// 获取性别
    /// - Returns: 性别
    private func getGender() -> Gender {
        guard isValid else {
            return .male
        }
        let numStr = numbers[14 ..< 17]
        let num = Int(numStr) ?? 0
        let gender: Gender = (num % 2 == 0) ? .female : .male
        return gender
    }
    
    /// 获取区域代码
    /// - Returns: 区域代码,如果身份证不合法，返回的就是空字符串
    private func getCityCode() -> String {
        guard isValid else {
            return ""
        }
        let numStr = numbers[..<6]
        return String(numStr)
    }
}
