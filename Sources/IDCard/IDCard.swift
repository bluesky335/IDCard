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

    public struct Birthday {
        public let year: String
        public let month: String
        public let day: String
        public let date: Date

        public init(year: String, month: String, day: String) {
            self.year = year
            self.month = month
            self.day = day
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            date = formater.date(from: "\(year)-\(month)-\(day)") ?? Date(timeIntervalSince1970: 0)
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
    
    /// 初始化
    /// - Parameter number: 身份证号码
    public init(number: String) {
        self.numbers = number.uppercased()
    }
    
    /// 获取身份证号码
    /// - Returns: 生日，如果是不符合规范的身份证，则返回时间戳为0的时间
    private func getBirthday() -> Birthday {
        guard self.isValid else {
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
            return false
        }

        var sum: Int = 0
        var signChar = ""
        for (index, c) in idStr.enumerated() {
            let i = 18 - index
            if i != 1 {
                guard let v = Int(String(c)) else {
                    return false
                }
                let weight = Int(pow(2, Float(i - 1))) % 11

                sum += v * weight
            } else {
                signChar = String(c)
            }
        }
        guard let a1 = a1Map[sum % 11] else {
            return false
        }

        var a1Str = "\(a1)"
        if a1 == 10 {
            a1Str = "X"
        }
        guard a1Str == signChar else {
            return false
        }
        return true
    }
    
    /// 获取性别
    /// - Returns: 性别
    private func getGender() -> Gender {
        guard self.isValid else {
            return .male
        }
        let numStr = numbers[14 ..< 17]
        let num = Int(numStr) ?? 0
        let gender: Gender = (num % 2 == 0) ? .female : .male
        return gender
    }
}
