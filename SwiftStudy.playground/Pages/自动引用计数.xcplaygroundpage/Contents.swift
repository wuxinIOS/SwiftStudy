//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 自动引用计数的工作机制
// 当你每次创建一个类的新的实例的时候，ARC会分配一块内存来存储该实例信息。内存中会包含实例的类型信息，以及和这个实例所有相关的存储型属性的值。
// 当实例不再被使用时，ARC释放实例所占用的内存。
// 为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。
// 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var referencel1: Person?
var referencel2: Person?
var referencel3: Person?

// 由于Person类的新实例被赋值给了reference1变量，所以reference1到Person类的新实例之间建立了一个强引用。正是因为这一个强引用，ARC 会保证Person实例被保持在内存中不被销毁。
referencel1 = Person(name: "John Appleseed")

// 如果你将同一个Person实例也赋值给其他两个变量，该实例又会多出两个强引用：
referencel2 = referencel1
referencel3 = referencel1

referencel1 = nil
referencel2 = nil
referencel3 = nil

// 类实例之间的循环强引用
// 如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
class PersonT {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    var tenant: PersonT?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: PersonT?
var unit4A: Apartment?

john = PersonT(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil
// Person和Apartment实例之间的强引用关系保留了下来并且不会被断开。

// 解决实例之间的循环强引用
// swift提供了两种办法来解决你在使用类的属性时所遇到的循环强引用问题：弱引用(weak reference)和物主引用(unowned reference).
// 弱引用和无主引用允许循环引用中的一个实例引用而另外一个实例不保持强引用。这样实例能够互相引用而不产生循环强引用。

// 弱引用
// 弱引用不会对其引用的实例保持强引用，因此而不会阻止ARC销毁被引用的实例。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
class PersonTT {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentT?
    deinit { print("\(name) is being deinitialized") }
}
class ApartmentT {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: PersonTT?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var andy: PersonTT?
var unit5A: ApartmentT?
andy = PersonTT(name: "Andy")
unit5A = ApartmentT(unit: "5A")
andy?.apartment = unit5A
unit5A?.tenant = andy

andy = nil

//无主引用
// 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
