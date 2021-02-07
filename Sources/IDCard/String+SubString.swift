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

// 通过整数下标运算符截取字符串
extension String {
    
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            let start = index(self.startIndex, offsetBy: value.lowerBound)
            let end = index(self.startIndex, offsetBy: value.upperBound)
            return self[start ... end]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            let start = index(self.startIndex, offsetBy: value.lowerBound)
            let end = index(self.startIndex, offsetBy: value.upperBound)
            return self[start ..< end]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[ ..<index(self.startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[ ...index(self.startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(self.startIndex, offsetBy: value.lowerBound)... ]
        }
    }
}
