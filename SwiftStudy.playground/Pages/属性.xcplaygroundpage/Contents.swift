//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算（不是存储）一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。



// 存储属性
// 简单来说，一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字 var 定义），也可以是常量存储属性（用关键字 let 定义）
// 可以在定义存储属性的时候指定默认值

struct FixedLengthRange {
    var firstValue: Int
    let lenght: Int
}

var rangeOfThreenItems = FixedLengthRange(firstValue: 0, lenght: 3)
rangeOfThreenItems.firstValue = 6

// 常量结构体的存储属性
// 如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行：
let rangeOfFourItems = FixedLengthRange(firstValue: 0, lenght: 4)
//rangeOfFourItems.firstValue = 2   会报错，由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。


// 延迟存储属性
// 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性。
// 注意：必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。

class DataImporter {
    
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建


// 计算属性
// 类、结构体和枚举可以定义计算属性
// 计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {// 重新定义新值的参数名,默认是 newValue
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print("\(initialSquareCenter.x),\(initialSquareCenter.y)")

square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 只读计算属性
// 只有getter 没有 setter 的计算属性就是 只读计算属性
// 必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
struct Cuboid {
    var witdh = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return witdh * height * depth
    }
}

let fourByFiveByTwo = Cuboid(witdh: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

// 属性观察器
//  属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
// 可以为除了延迟存储属性之外的其他 存储属性 添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。
// 可以为属性添加如下的一个或全部观察器：
    // 1. willSet 在新的值被设置之前调用
    // 2. didSet 在新的值被设置之后立即调用
// 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器  在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) step")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360

stepCounter.totalSteps = 980

// 类型属性
// 实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互独立。 也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是 类型属性
// 类型属性用于定义某个类型所有实例共享的数据。比如所有实例都能用一个常量(就像C语言的静态常量)，或者所有实例都能访问的一个变量(就像C语言中的静态变量).
// 注：跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符

// 类型属性语法
// 在C或Objective-C中，与某个类型关联的静态常量和静态变量，是作为全局(global)静态变量定义的。但是在swift中，类型属性是作为类型定义的一部分在类型最外层的花括号内，因此它的范围也就在类型支持的范围内。
// 使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。

struct SomeStructure {
    static var storedTypeProperty = "Some Value."
    static var computeTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storeTypeProperty = "Some value."
    static var computeTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storeTypeProperty = "Some value"
    static var computeTypeProperty: Int {
        return 27
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 获取和设置类型属性的值
// 也是通过点运算符来访问，但是，类型属性是通过类型本身来访问，而不是实例。
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computeTypeProperty)
print(SomeClass.computeTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
    
}


var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(AudioChannel.maxInputLevelForAllChannels)
