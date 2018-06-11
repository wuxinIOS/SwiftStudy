//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var x = 0.0, y = 0.0, z = 0.0//一行声明多个常量或变量

var red, green, blue: Double//定义多个同类型的变量

var welcomeMessage: String



print("hello", "happy", "day", separator: "-")

//无符号型 8位长度
var minValue: UInt8 = UInt8.min
var maxValue = UInt8.max

//Int 有符号型
//UInt 无符号型
var minValueInt = Int.min //与当前平台的原生字长相同
var maxValueInt = Int.max

let anotherPi = 3 + 0.014159//Double类型
/**
整数字面量可以被写作：
一个十进制数，没有前缀
一个二进制数，前缀是0b
一个八进制数，前缀是0o
一个十六进制数，前缀是0x
*/

//整数转换
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
// SomeType(ofInitialValue)是调用swift构造器并传入一个初始值的默认方法。
// 注意，你并不能传入任意类型的值，只能传入 UInt16 内部有对应构造器的值。不过你可以扩展现有的类型来让它可以接收其他类型的值（包括自定义类型），请参考扩展。

//整数和浮点数转换
// 必须显示指定类型
let three = 3
let pointOneFourOneFiveNine = 0.14159

let pi = Double(three) + pointOneFourOneFiveNine

let integerPi = Int(pi)//结果：3

//类型别名 （type aliases）给现有类型定义另一个名字 使用typealias
typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min


//布尔值
let orangesAreOranges = true

let trunipsAreDelicious = false

if trunipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

//元组
//元组(tuples)把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求相同类型
let http404Erro = (404, "Not found")

let (statusCode, statusMessage) = http404Erro
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Erro
print("The status code is \(justTheStatusCode)")

//通过下标来访问元组中的单个元素，下标从0开始
print("The status code is \(http404Erro.0)")
print("The status message is \(http404Erro.1)")

//在定义元组的时候给单个元素命名
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

//可选类型(optionals)来处理可能缺失的情况
let possibleNumber = "123"

let convertedNumber = Int(possibleNumber)//可选型：Int?

//nil
// 可以给可选变量赋值 nil 来表示它没有值
var serverResponseCode: Int? = 404
serverResponseCode = nil
//注意：nil不能用于非可选的常量和变量。
// 如果你声明一个可选常量或者变量但是没有赋值，他们会自动被设置为 nil
var surveyAnswer: String?
//注意：swift的nil和OC中的nil并不一样。在OC中，nil是一个指向不存在对象的指针。在swift中，nil不是指针--他是一个确定的值，用来表示值缺失。任何类型的可选状态都可以设置为 nil

//if语句以及强制解析
if convertedNumber != nil {
    print("converttedNumber contains some integer value.")
}
//强制解析：！,但是在强制解析值之前，一定要确定可选包含一个非 nil 的值
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!)")
}

//可选绑定
//if let constanName = somOptional {
//    statements
//}

if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
//你可以包含多个可选绑定或多个布尔条件在一个 if 语句中，只要使用逗号分开就行。只要有任意一个可选绑定的值为nil，或者任意一个布尔条件为false，则整个if条件判断为false，这时你就需要使用嵌套 if 条件语句来处理
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
//隐式解析可选类型
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumedString: String! = "An implicitily optional"
let implicityString: String = assumedString//不需要感叹号

// 可以把隐式解析可选类型当做普通可选类型来判断或者咋可选绑定中使用隐式解析可选类型来检查并解析它的值

// 断言 和 先决条件
// 如果断言或者先决条件中的布尔条件评估的结果为 true（真），则代码像往常一样继续执行
// 如果布尔条件评估结果为false（假），程序的当前状态是无效的，则代码执行结束，应用程序中止。
// 断言只会在开发环境中产生作用   先决条件在开发环境和生产环境都产生作用

//使用断言进行调试
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")
//如果代码已经检查了条件,可以使用 assertionFailure(_:file:line:)函数来表明断言失败了如：
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age > 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

//强制执行先决条件
// 当一个条件可能为false（假），但是继续执行代码要求条件必须为true的时候，需要使用先决条件，例如使用先决条件来检查是否下标越界，或者来检查是否将一个正确的参数传给函数
// 你可以使用全局 precondition(_:_:file:line:) 函数来写一个先决条件。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示：
precondition(age > 0, "A person's age can't be less than zero.")











































