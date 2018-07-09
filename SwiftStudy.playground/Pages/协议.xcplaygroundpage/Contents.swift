//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
//包含了：
// 1.协议语法
// 2.属性要求
// 3.方法要求
// 4.Mutating方法要求
// 5.构造器要求
// 6.协议作为类型
// 7.委托代理模式
// 8.通过扩展添加协议一致性
// 9.通过扩展遵循协议
// 10.协议类型的集合
// 11.协议的继承
// 12.类类型d专属协议
// 13.检查协议一直性
// 14.可选的协议要求
// 15.协议扩展

//: [Next](@next)
// 协议
// 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。

// 协议语法
/**
 protocol SomeProtocol {
    // 这里是协议的定义部分
 }
 
 // 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 struct SomeStructure: FirstProtocol, AnotherProtocol {
 
 }
 
 // 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 class SomeStructure: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // 这里是类的定义部分
 }
 */

// 属性要求
// 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
// 协议总是用 var 关键字来申明变量。
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettbale: Int { get }
}

// 在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}
// FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName。
struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}

let ncc1701 = Starship(name: "Enterprise", prefix: "USS")


// 方法要求
// 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
// 在协议中定义类方法的时候，总是使用 static 关键字为前缀。当类类型遵循协议时， 除了 static 关键字，还可以使用 class 关键字作为前缀
/**
 protocol SomeProtocol {
    static func someTypeMethod()
 }
 */

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
    
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")


// Mutating方法要求
// 有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值
// 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

// 构造器要求
// 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明。
/**
 protocol SomeProtocol {
 init(someParameter: Int)
 }
 class SomeClass: SomeProtocol {
     required init(someParameter:Int) {
        // 这里是构造器的实现部分
    }
 }
 */

// 构造器要求 在类中的实现
// 你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
// 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
/**
 protocol SomeProtocol {
     init()
 }
 
 class SomeSuperClass {
     init() {
     // 这里是构造器的实现部分
     }
 }
 
 class SomeSubClass: SomeSuperClass, SomeProtocol {
     // 因为遵循协议，需要加上 required
     // 因为继承自父类，需要加上 override
     required override init() {
     // 这里是构造器的实现部分
     }
 }
 */

// 可失败构造器要求

// 协议作为类型
// 尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用
// 协议可以像其他普通类型一样使用，使用场景如下：
// 1.作为函数、方法或构造器中的参数类型或返回值类型
// 2.作为常量、变量或属性的类型
// 3.作为数组、字典或其他容器中的元素类型

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
// generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求。
// 构造器有一个名为 generator，类型为 RandomNumberGenerator 的形参。在调用构造方法创建 Dice 的实例时，可以传入任何遵循 RandomNumberGenerator 协议的实例给 generator。

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


// 委托(代理)模式

protocol DiceGame {
    var dice: Dice { get }
    
    func play()
}


protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDicRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}
