//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）
// swift中的扩展可以：
// 1.添加计算型属性和计算型类型属性
// 2.定义实例方法和类型方法
// 3.提供新的构造器
// 4.定义下标
// 5.定义和使用新的嵌套类型
// 6.使一个已有类型符合某个协议

// 扩展语法
// 使用关键字 extension  来申明扩展
/**
 extension SomeType {
    // 为 SomeType 添加的新功能写到这里
 }
 */
// 通过扩展来遵守协议
/**
 extension SomeType: SomeProtocol, AnotherProtocol {
    // 协议的实现写到这里
 }
 */

// 计算型属性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m:  Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let ontInch = 25.4.m
print("One inch is \(ontInch) meters")

let threeFeet = 3.ft
print("Threet feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器

// 构造器
// 扩展能为新类添加新的便利构造器，但是不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
// 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

extension Rect {
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY),
                  size: size)
    }
    
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size:Size(width: 3.0, height: 3.0))


//方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0 ..< self {
            task()
        }
    }
}

3.repetitions {
    print("Hello")
}


// 可变实例方法
// 通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating，正如来自原始实现的可变方法一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

// 下标
extension Int {
    subscript(digitIndext: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndext {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

658493857[3]
658493857[9]

// 嵌套类型
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
    
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("-", terminator: " ")
        case .Zero:
            print("0", terminator: " ")
        case .Positive:
            print("+", terminator: " ")
        }
    }
}
printIntegerKinds([1, 34, -43, 0, 4, -6, 0])
