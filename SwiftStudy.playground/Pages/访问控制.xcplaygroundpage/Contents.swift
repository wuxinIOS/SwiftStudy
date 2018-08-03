//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// 模块 和 源文件
// 模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
// 在 Swift 中，Xcode 的每个 target（例如框架或应用程序）都被当作独立的模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时，框架内容都将属于这个独立的模块。

// 源文件就是swift中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。

// 访问级别
// 1.Open 和 Public 级别都可以上实体被同一个模块源文件中的所有实体访问，在模块外也可以通过导入改模块来访问源文件里的所有实体。
// 2.Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
// 3.File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
// 4.Private限制实体只能在其定义的作用域，以及同一文件内的extension访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。

// Open为最高访问级别(限制最少)，Private为最低访问级别（限制最多）。
// Open 和 Public的区别
// 1.Open只能作用于类和类的成员
// 2.Public或者其它更严访问级别的类，只能在其定义的模块内部被继承。
// 3.Public或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
// 4.Open的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
// 5.Open的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写


// 访问级别基本原则
// 不可以在某个实体中定义访问级别更低的实体。

// 默认访问级别
// 如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。因此，在大多数情况下，我们不需要显式指定实体的访问级别。

// 访问控制语法
// public class SomePublicClass {}
// internal class SomeInternalClass {}
// fileprivate class SomeFilePrivateClass {}
// private class SomePrivateClass {}

// public var somePublicVariable = 0
// internal let someInternalConstant = 0
// fileprivate func someFilePrivateFunction() {}
// private func somePrivateFunction() {}

// 自定义类型
public class SomePublicClass {                  // 显式 public 类
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

class SomeInternalClass {                       // 隐式 internal 类
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

fileprivate class SomeFilePrivateClass {        // 显式 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

private class SomePrivateClass {                // 显式 private 类
    func somePrivateMethod() {}                  // 隐式 private 类成员
}


// 元组类型
// 元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal，另一个类型为 private，那么这个元组的访问级别为 private。

// 函数类型
// 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。

//下面的例子定义了一个名为 someFunction() 的全局函数，并且没有明确地指定其访问级别。也许你会认为该函数应该拥有默认的访问级别 internal，但事实并非如此。事实上，如果按下面这种写法，代码将无法通过编译：
/**
 func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // 此处是函数实现部分
 }
*/

// 原因：因为函数的返回值类型是一个元组，该元组包含的类型，访问级别是private，因此该函数的返回类型为 privtate,所以必须使用 private修饰符，明确指定该函数的访问级别：如下：
private func someFunction() -> (SomeInternalClass, SomePrivateClass)? {
    
    return nil;
    
}


// 枚举类型
// 枚举成员的访问级别和该枚举类型相同，不能为枚举成员单独指定不同的访问级别

// 子类
// 子类的访问级别不得高于父类的访问级别。
// 你可以在符合当前访问级别的条件下重写任意类成员。


// 常量、变量、属性、下标
// 常量、变量、属性不能拥有比它们的类型更高的访问级别。
// 如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：


// 构造器
// 自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一的例外是必要构造器，它的访问级别必须和所属类型的访问级别相同
// 如同函数或方法的参数，构造器参数的访问级别也不能低于构造器本身的访问级别。

// 默认构造器
// 如默认构造器所述，Swift 会为结构体和类提供一个默认的无参数的构造器，只要它们为所有存储型属性设置了默认初始值，并且未提供自定义的构造器。默认构造器的访问级别与所属类型的访问级别相同

// 结构体默认的成员逐一构造器
// 如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。

// 协议
// 如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可。这将限制该协议只能在适当的访问级别范围内被采纳。
// 协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。
// 注意
// 如果你定义了一个 public 访问级别的协议，那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型，例如，当类型是 public 访问级别时，其成员的访问级别却只是 internal。

//协议继承
// 如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议定义为 public 协议。

// 协议一致性
// 一个类型可以采纳比自身访问级别低的协议。采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。

// Extension
// Extension 可以在访问级别允许的情况下对类、结构体、枚举进行扩展。Extension 的成员具有和原始类型成员一致的访问级别


