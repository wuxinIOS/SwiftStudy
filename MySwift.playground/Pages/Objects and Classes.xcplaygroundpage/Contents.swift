//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//对象和类
class Shape {
    let width = 10
    var numberofSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberofSides) side."
    }
    func shapeWidth(width:Float) -> String{
        return "This shape width is \(width)."
    }
    
}

var shape = Shape()
shape.numberofSides = 7
var shapeDescription = shape.simpleDescription()


//每个属性都需要赋值——无论是通过声明（就像 numberOfSides）还是通过构造器（就像 name）。
//如果你需要在删除对象之前进行一些清理工作，使用 deinit 创建一个析构函数。

class NameShape {
    var numberofSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberofSides) sides."
    }
    
}

class Square: NameShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberofSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A shape with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()


class Circle: NameShape {
    var radio: Double
    
    init(radio: Double, name: String) {
        self.radio = radio
        super.init(name: name)
        numberofSides = 1
    }
    
    func area() -> Double {
        return radio * radio * Double.pi
    }
    
    override func simpleDescription() -> String {
        return "A shape with side of radio \(radio)"
    }
}

//如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用 willSet 和 didSet。写入的代码会在属性值发生改变时调用，但不包含构造器中发生值改变的情况
class EquilateralTriangle: NameShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberofSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangel")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)


class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
    
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength





















