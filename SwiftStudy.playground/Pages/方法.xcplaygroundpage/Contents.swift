//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 方法
// 方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务和功能。类、结构体、枚举也可以定义实例方法；类型方法与类型本身想关联。类型方法和object-c中的类方法相似。

// 实例方法（Instance Methods）
// 实例方法是属于某个特定类、结构体或者枚举类型实例的方法。
// 实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。
class Counter {
    var count = 0
    func increment() {
        count += 1
        //或者写成  self.count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset(by amount: Int = 0) {
        if amount != 0 {
            count = amount
        } else {
            count = 0
        }
    }
}

let counter = Counter()
//初始计算值为0
counter.increment()
counter.increment(by: 5)
counter.reset()

// self 属性
// 类型的每一个实例都有一个隐含属性叫做self,self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例。
// 使用self的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
struct Point {
    var x = 0.0, y = 0.0
    func inTotheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.inTotheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// 在实例方法中修改值类型
// 结构体和枚举是值类型。默认情况下，值类型的属性不能在他的实例方法中被修改
// 如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。

struct PointT {
    var x = 0.0, y = 0.0
    mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePointT = PointT(x: 1.0, y: 1.0)
somePointT.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePointT.x), \(somePointT.y))")

// 在可变方法中给 self 赋值
// 可变方法能够赋值给隐含属性 self 一个全新的实例。上面 Point 的例子可以用下面的方式改写：
struct PointTT {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = PointTT(x: deltaX, y: deltaY)
    }
}

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()

//类型方法
// 在方法的func关键字之前加上关键字 static,来指定类型方法。类还可以用关键字class来允许子类重写父类的实现方法。

class SomeClass {
    
    
}
