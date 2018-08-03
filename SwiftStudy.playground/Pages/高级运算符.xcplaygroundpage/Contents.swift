//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 位运算符

// 按位取反运算符
// 按位取fan运算符(~)可以对一个数值的全部比特位进行取反：
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

// 按位与运算符
// 按位与运算符（&）可以对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1：
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let midddleFourBits = firstSixBits & lastSixBits

// 按位异或运算符
// 按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1：
let firstBits: UInt8 = 0b00010100
let lastBits: UInt8 = 0b00000101
let outputBits = firstBits ^ lastBits

// 按位左移、右移运算符
// 按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
//对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。

// 无符号整数的移位运算
// 规则如下：
// 1.已经存在的位按指定的位数进行左移和右移。
// 2.任何因移动而超出整型存储范围的位都会被丢弃。
// 3.用 0 来填充移位后产生的空白位。

let shiftBits: UInt8 = 4 // 00000100
shiftBits << 1           // 00001000
shiftBits << 2           // 00010000
shiftBits << 5           // 10000000
shiftBits << 6           // 00000000
shiftBits >> 2           // 00000001

// 可以使用移位运算对其他的数据类型进行编码和解码：
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16

// 优先级 和 结合性
// 乘法与取余的优先级相同。这时为了得到正确的运算顺序，还需要考虑结合性。乘法与取余运算都是左结合的。

// 运算符函数
// 类和结构体可以为现有的运算符提供自定义的实现，这通常被称为 运算符重载

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0);

let combinedVector = vector + anotherVector


// 前缀 和 后缀 运算符
// 要实现前缀或者后缀运算符，需要在声明运算的时候在func关键字词之前指定 prefix 或者 postfix修饰符：
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let postitive = Vector2D(x: 3.0, y: 4.0);
let negative = -postitive

// 复合赋值运算符
// 复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// 等价运算符
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    static func != (left:Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}


//自定义运算符
// 新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：

 prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        
        return vector
    }
}
