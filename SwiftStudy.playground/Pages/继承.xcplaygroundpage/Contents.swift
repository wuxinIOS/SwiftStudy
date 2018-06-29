//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 继承
// 在swift中，继承是区分 类 与其他类型的一个基本特征

// 定义一个基类
// 不继承于其他的类，称之为基类

class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle:\(someVehicle.description)")

// 子类生成
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle:\(bicycle.description)")

// 子类还可以继续被其他类继承
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0

// 重写
// 子类可以为继承来的实例方法、类方法、实例属性或下标提供自己定制的实现。这称为重写。
// 如果要重写某个特性，你需要在重写定义的前面加上 override 关键字
/**
 1.在方法someMethod()的重写实现中，可以通过super.someMethod()来调用超类版本的someMethod()方法。
 2.在属性someProperty的 getter 或 setter 的重写实现中，可以通过super.someProperty来访问超类版本的someProperty属性。
 3.在下标的重写实现中，可以通过super[someIndex]来访问超类版本中的相同下标。
 */

// 重写方法：
// 在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或者替代的方法实现
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()


//重写属性：
// 重写属性的 Getters 和 Setters
// 你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。
// 可以将继承来的只读属性重写为读写属性，但不能将继承来的读写属性重写为只读属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 23.0
car.gear = 3
print("Car:\(car.description)")


//重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// 防止重写
// 你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。

enum OCBool {
    case ocTrue
    case ocFalse
}

extension OCBool {
    
    init() {
        self = .ocFalse
    }
    
}
