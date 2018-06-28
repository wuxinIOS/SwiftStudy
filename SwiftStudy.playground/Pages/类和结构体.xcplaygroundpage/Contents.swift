//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 类 和 结构体 对比
// 共同点：
// 1.定义属性用于存储值
// 2.定义方法用于提供功能
// 3.定义下标操作使得可以通过下标语法来访问实例所包含的值
// 4.定义构造器用于生成初始值
// 5.实现协议以提供某种标准功能
// 6.通过扩展以增加默认实现的功能

// 与结构体相比，类还有如下的附加功能:
// 1.继承允许一个类继承另一个类的特征
// 2.类型转换允许在运行时检查和解释一个类实例的类型
// 3.析构器允许一个类实例释放任何其他所被分配的资源
// 4.引用计数允许对一个类的多次引用

//注意：结构体总是通过被复制的方式在代码中传递，不使用引用计数。

// 定义语法
// 使用 class 和 struct来分别表示类 和结构体

class SomeClass {
    
}

struct SomeStructre {
    
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


let someResolution = Resolution()
let someVideoMode = VideoMode()
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

// 所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
// 类实际是没有默认的成员逐一构造器
let vga = Resolution(width: 640, height: 480)

// 结构体 和 枚举 是 值类型
// 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
// 在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。

let videoMode1 = VideoMode()
videoMode1.resolution.width = 1024

var videoMode2 = videoMode1

videoMode2.resolution.width = 1135

print("videoMode1 resolution width is \(videoMode1.resolution.width)")
print("videoMode2 resolution width is \(videoMode2.resolution.width)")


var resolutionT = videoMode1.resolution

resolutionT.width = 0

print("videoMode1 resolution width is \(videoMode1.resolution.width)")
print("videoMode2 resolution width is \(videoMode2.resolution.width)")
print("resolutionT width is \(resolutionT.width)")


// 恒等运算符
// 等价于 (===)
// 不等价于 (!==)
// 运用这两个运算符检测两个常量或者变量是否引用同一个实例：
if videoMode1 === videoMode2 {
    print("videoMode1 and videoMode2 refer to the same Resolution instance.")
}

// 类 和 结构体 的选择
// 通用的准则，当符合一条或多条以下条件时，考虑构建结构体
// 1.该数据结构的主要目标是用来封装少量相关简单数据值
// 2.有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
// 3.该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
// 4.该数据结构不需要去继承另一个既有类型的属性或者行为。

// Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。

// Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
