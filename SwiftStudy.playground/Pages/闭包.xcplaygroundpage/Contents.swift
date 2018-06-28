//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//闭包
// 闭包是自包含的函数代码块，可以在代码中被传递和使用。
// 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量
// 闭包采取如下三种形式之一：
// 1.全局函数式一个有名字但不会捕获任何值的闭包
// 2.嵌套函数是一个有名字并可以捕获起封闭函数域内值的闭包
// 3.闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

// 语法优化：
// 1.利用上下文推断参数和返回值类型
// 2.隐式返回单表达式闭包，即单表达式闭包可以省略return关键字
// 3.参数名称缩写
// 4.尾随闭包语法

//闭包表达式
// sorted方法
// sorted(by:) 方法会返回一个与原数组大小相同，包含同类型元素且元素已正确排序的新数组。原数组不会被 sorted(by:) 方法修改
 // sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数需要返回true，反之返回false。

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)


// 闭包表达式语法
/**
 1.一般形式：
 { (paremeters) -> returnType in
     statements
 }
 */

var reversedNames_t1 = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 根据上下文推断类型
// 排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
// 通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})


// 单表达式闭包隐式返回
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})


// 参数名称缩写
// Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。
// 如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reversedNames = names.sorted(by: {$0 > $1})


//尾随闭包
/**
 
 func someFunctionThatTakesAClosure(closure: () -> Void) {
 // 函数体部分
 }
 
 // 以下是不使用尾随闭包进行函数调用
 someFunctionThatTakesAClosure(closure: {
 // 闭包主体部分
 })
 
 // 以下是使用尾随闭包进行函数调用
 someFunctionThatTakesAClosure() {
 // 闭包主体部分
 }
 */
var reversedNames_t = names.sorted() { $0 < $1}
print(reversedNames_t)

// 如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
reversedNames_t = names.sorted {$0 > $1}

//  Array 类型有一个 map(_:) 方法，这个方法获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510, 0]

let strings = numbers.map {
    (number) -> String in
    
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}
print(strings)


// 值捕获
// 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。

func makeIncrementer(forInscrement amount: Int) -> () -> Int {
    
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementerTen = makeIncrementer(forInscrement: 10)

var value = incrementerTen()

value = incrementerTen()


//闭包是引用类型
//这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：

// 逃逸闭包
// 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。 当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
// 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self

var completionHandlers:[() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void ) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure:()->Void) {
    closure()
}

class SomeClass {
    
    var x = 10
    
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
    
}

let instance = SomeClass()
instance.doSomething()

print(instance.x)

completionHandlers.first?()
print(instance.x)


// 自动闭包


