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


// 通过扩展添加协议一致性
// 可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。
protocol TextRepresentable {
    var textvalDescription: String { get }
    
}

extension Dice: TextRepresentable {
    var textvalDescription: String {
        return "A \(sides)-sided dice"
    }
    
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textvalDescription)


// 通过扩展遵循协议
// 当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议

struct Hamster {
    var name: String
    var textvalDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textvalDescription)

// 协议类型的集合
// 协议类型可以在数组或者字典这样的集合中使用
let things: [TextRepresentable] = [d6, d12, simonTheHamster]

for thing in things {
    print(thing.textvalDescription)
}

// 协议的继承
// 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
/**
    protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
        //这里是协议的定义部分
 
    }
 
 */

protocol PrettyTxtRepresentable: TextRepresentable {
    var prettyTextRepresentable: String  { get }
}

// 类类型专属协议
// 可以在协议的继承列表中，通过添加class关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议。class关键字必须第一出现在协议的继承列表中，在其他继承的协议之前
/**
    protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
 

    }
 */

// 协议合成
// 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PersonT: Named, Aged {
    var name: String
    var age: Int
    
   
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)")
}

// wishHappyBirthday(to:) 函数的参数 celebrator 的类型为 Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可。

let birthdayPerson = PersonT(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)

beginConcert(in: seattle)

// 检查协议一致性
// 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
// is 用来检查实例是否符合某个协议，如符合则返回true，否则返回false
// as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回nil
// as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    
    init(radius: Double) {
        self.radius = radius
    }
    
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objeects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objeects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea)")
    } else {
        print("Something that does't have an ared")
    }
}

// 可选的协议要求
// 协议可以定义 可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用optional关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上@objc属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount =  dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}


// 协议扩展
// 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generatorT = LinearCongruentialGenerator()
print("Here's a random number: \(generatorT.random())")
print("And here's a random Boolean: \(generatorT.randomBool())")

// 提供默认实现
// 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。

// 为协议扩展添加限制条件
// 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述

// 扩展 CollectionType 协议，但是只适用于集合中的元素遵循了 TextRepresentable 协议的情况：
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textvalDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
