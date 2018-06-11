//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// 算术运算符
// + - * /
// 求余运算符 %
//  a % b 和 a % -b 的结果是相同的。
let i = 9 % 4 //  1
let a = -9 % 4// -1
let z = -9 % -4// -1
let y = 9 % -4 // 1

//组合赋值运算符
var b = 1
b += 2

//比较运算符
// 元组的比较
(1, "zebra") < (1, "zebrb")//true
(1, "apple") < (2, "bird")//ture
(4, "dog") == (4, "dog")//true

("blue", -1) < ("purpel", 1)
//("blue", false) < (purple, true) 不能被比较

//空合运算符
// a ?? b 将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b,表达式a必须是optional类型。默认值b的类型必须要和a存储值的类型保持一致
var c: Int?
let d = c ?? 4 // 短路求值

//区间运算符
// 闭区间
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

//半开区间运算符 (a..<b) 不包括b这个值
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第\(i+1)个人叫\(names[i])")
}

//单侧区间
// 闭区间操作符有另一个表达形式，可以表达往一侧无限延伸的区间
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}

for name in names[..<2] {
    print(name)
}


//逻辑运算符





