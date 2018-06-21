//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func greet(person: String) -> String {
    let greeting = "Hello, " + person
    return greeting
}

print(greet(person: "Anna"))

print(greet(person: "Brian"))

func greetAgain(person: String) -> String {
    return "Hello agin, " + person
}


func greet(person: String, alreadyGreeted: Bool) -> String {
    
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

print(greet(person: "Tim", alreadyGreeted: true))


func printAndCount(string: String) -> Int {
    
    print(string)
    return string.count
}

func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

printWithoutCounting(string: "hello, world")

//多重返回值函数

//可选元组返回类型
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    
    if array.isEmpty {
        return nil
    }
    
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1 ..< array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
    
}

if let bounds = minMax(array: [1, -10, 35, 5, 90, 1]) {
    
    print("min is \(bounds.min) and max is \(bounds.max)")
}

//函数参数标签 和 参数名称

// 每个函数参数都有一个参数标签( argument label )以及一个参数名称( parameter name )。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签。

//指定参数标签
func someFunction(argumentLabel parameterName: Int) {
    print(parameterName)
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}

print(greet(person: "Bill", from: "Cupertino"))


//忽略参数标签
func someFuntion(_ firstParameterName: Int, secondParameterName: Int) {
    
}

someFuntion(1, secondParameterName: 2)

// 默认参数值
// 在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。
// 把不带默认值的参数放在函数参数列表的最前面
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
 
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
    print(parameterWithDefault + parameterWithoutDefault)
}

someFunction(parameterWithoutDefault: 3)

someFunction(parameterWithoutDefault: 1, parameterWithDefault: 2)


//可变参数
// 一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。
// 一个函数最多拥有一个可变参数

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
    
}

arithmeticMean(1, 3, 5, 7)

arithmeticMean(3, 6, 8)

arithmeticMean(3, 8.25, 18.75)

// 输入输出参数
// 函数参数默认是常量。
// 如果想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）
// 定义一个输入输出参数时，在参数定义前加 inout 关键字  一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。只能传递变量给输入输出参数

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
print("someInt is ago \(someInt), and anotherInt is ago \(anotherInt)")

swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

// 函数类型
// 类型由函数的参数类型和返回类型组成
func addTwonInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//上述函数的类型是: (Int, Int) -> (Int)

//使用函数类型
//  使用函数类型就像使用其他类型一样
var mathFunctiion: (Int, Int) -> Int = addTwonInts
print("Result:\(mathFunctiion(2, 5))")

mathFunctiion = multiplyTwoInts
print("Result:\(mathFunctiion(2, 5))")

let anotherMathFunction = addTwonInts

// 函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result:\(mathFunction(a, b))")
}

printMathResult(addTwonInts, 1, 1)
printMathResult(multiplyTwoInts, 8, 2)

// 函数类型作为返回类型
// 可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print(moveNearerToZero(currentValue))

//while currentValue != 0 {
//    print("\(currentValue)")
//    currentValue = moveNearerToZero(currentValue)
//}

print("zero!")


