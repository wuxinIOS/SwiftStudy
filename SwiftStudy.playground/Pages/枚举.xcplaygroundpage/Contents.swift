//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 枚举语法
// 使用 enum 关键字来创建枚举
/**
 enum SomeEnumeration {
    //枚举定义放在这里
 }
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，north，south，east和west不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, nepune
}

var directionToHead = CompassPoint.west

directionToHead = .east

// 使用 Switch 语句匹配枚举值
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

// 当不需要匹配每个枚举成员的时候，你可以提供一个default分支来涵盖所有未明确处理的枚举成员：
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//关联值
// 你可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(9, 85909, 51226, 3)
//productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR code:\(productCode).")
}

// 如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
switch productBarcode {
case let .upc(numberSystem, manfacturer, product, check):
    print("UPC: \(numberSystem),\(manfacturer),\(product),\(check)")
case let .qrCode(productCode):
    print("QR code:\(productCode).")
}


//原始值
// 枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
// 原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
// 原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
// 原始值的隐式赋值
// 在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
// 例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0。

enum PlanetT: Int {
    case mercury, venus, earth, mars, jupiter, saturn, uranus,neptune
}

// 当使用字符串作为枚举类型的原始值，每个枚举成员的隐式原始值为改枚举成员的名称
enum CompassPointT: String {
    case north, south, east, west = "WEST"
}

let earthsOrder = PlanetT.earth.rawValue

let sunsetDirection = CompassPointT.west.rawValue

//使用原始值初始化枚举实例
let possiblePlanet = PlanetT(rawValue: 0)
//在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做rawValue的参数，参数类型即为原始值类型，返回值则是枚举成员或nil。

let positionToFind = 11
if let somePlanet = PlanetT(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}


// 递归枚举
// 递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// 你也可以在枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的：

indirect enum ArithmeticExpressionT {
    case number(Int)
    case addition(ArithmeticExpressionT, ArithmeticExpressionT)
    case multiplication(ArithmeticExpressionT, ArithmeticExpressionT)
}

let five = ArithmeticExpressionT.number(5)
let four = ArithmeticExpressionT.number(4)
let sum = ArithmeticExpressionT.addition(five, four)
let product = ArithmeticExpressionT.multiplication(sum, ArithmeticExpressionT.number(2))

func evaluate(_ expression: ArithmeticExpressionT) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
