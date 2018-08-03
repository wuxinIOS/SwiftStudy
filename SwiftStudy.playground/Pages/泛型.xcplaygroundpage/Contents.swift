//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 本页包含内容
// 1.泛型所解决的问题
// 2.泛型函数
// 3.类型参数
// 4.命名类型参数
// 5.泛型类型
// 6.扩展一个泛型类型
// 7.类型约束
// 8.关联类型
// 9.泛型where语句
// 10.具有泛型where子句的扩展
// 11.具有泛型where子句的关联类型
// 12.泛型下标


// 泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。它能让你避免代码的重复，用一种清晰和抽象的方式来表达代码的意图。

// 泛型所解决的问题
func swapTowInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

swapTowInts(&someInt, &anotherInt)
print("sometInt is now \(someInt), and anotherInt is now \(anotherInt)")

func swapTwoSting(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 泛型函数
// 泛型函数可以适用于任何类型，下面的 swapTwoValues(_:_:) 函数是上面三个函数的泛型版本：
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 这个函数的泛型版本使用了占位类型名（在这里用字母 T 来表示）来代替实际类型名（例如 Int、String 或 Double）。占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才会根据所传入的实际类型决定 T 所代表的类型。

swapTwoValues(&someInt, &anotherInt)
print("sometInt is now \(someInt), and anotherInt is now \(anotherInt)")

var someString = "Hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("sometInt is now \(someString), and anotherInt is now \(anotherString)")


// 类型参数
// 在上面的 swapTwoValues(_:_:) 例子中，占位类型 T 是类型参数的一个例子。类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>）。
// 一旦一个类型参数被指定，你可以用它来定义一个函数的参数类型，或作为函数返回类型，还可以用作函数主体中的注释类型。类型参数会在函数调用时被实际类型所替换。

// 命名类型参数
// 在大多数情况下，类型参数具有一个描述性名字，例如 Dictionary<Key, Value> 中的 Key 和 Value，以及 Array<Element> 中的 Element，这可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字母来命名，例如 T、U、V，正如上面演示的 swapTwoValues(_:_:) 函数中的 T 一样。

// 注意
//  请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。

// 泛型类型
// 除了泛型函数，Swift 还允许你定义泛型类型。这些自定义类、结构体和枚举可以适用于任何类型，类似于 Array 和 Dictionary。
struct IntStack {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// 注意，Stack 基本上和 IntStack 相同，只是用占位类型参数 Element 代替了实际的 Int 类型。这个类型参数包裹在紧随结构体名的一对尖括号里（<Element>）。
// 由于 Stack 是泛型类型，因此可以用来创建 Swift 中任意有效类型的栈，就像 Array 和 Dictionary 那样。

var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
stackOfString.push("cuatro")

let fromTheTop = stackOfString.pop()


// 扩展一个泛型类型
// 当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表。原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfString.topItem {
    print("The top item on the stack is \(topItem)")
}

// 类型约束
// swapTwoValues(_:_:) 函数和 Stack 类型可以作用于任何类型。不过，有的时候如果能将使用在泛型函数和泛型类型中的类型添加一个特定的类型约束，将会是非常有用的。类型约束可以指定一个类型参数必须继承自指定类，或者符合一个特定的协议或协议组合。
// 类型约束语法
// 你可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型参数列表的一部分。对泛型函数添加类型约束的基本语法如下所示
/**
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
 
 
    }
 
 */
 // 上面这个函数有两个类型参数。第一个类型参数 T，有一个要求 T 必须是 SomeClass 子类的类型约束；第二个类型参数 U，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。
func findIndex(ofSting valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]

if let foundIndex = findIndex(ofSting: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

/**
func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
*/
// 上面所写的函数无法通过编译。问题出在相等性检查上，即 "if value == valueToFind"。不是所有的 Swift 类型都可以用等式符（==）进行比较。比如说，如果你创建一个自定义的类或结构体来表示一个复杂的数据模型，那么 Swift 无法猜到对于这个类或结构体而言“相等”意味着什么。正因如此，这部分代码无法保证适用于每个可能的类型 T，当你试图编译这部分代码时会出现相应的错误。
// Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.1415, 0.1, 9.3])

let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])


// 关联类型
// 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStackT: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int{
        return items[i]
    }
}

struct StackT<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}


// 约束关联类型
// 你可以给协议里的关联类型添加类型注释，让遵守协议的类型必须遵循这个约束条件
protocol ContainerT {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
}

extension Array: Container {}


// 泛型 where 语句
// 为关联类型定义约束也是非常有用的。你可以在参数列表中通过 where 子句为关联类型定义约束。你能通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。你可以在函数体或者类型的大括号之前添加 where 子句。

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        //检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

var stackOfStringT = StackT<String>()
stackOfStringT.push("uno")
stackOfStringT.push("dos")
stackOfStringT.push("tres")

var arrayOfString = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStringT, arrayOfString) {
    print("All items match.")
} else {
    print("Not all items match.")
}

// 具有泛型 where 子句的扩展
extension StackT where Element: Equatable {
    
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else { return false }
        
        return topItem == item
    }
    
}

if stackOfStringT.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element something else.")
}

// 可以使用泛型 where 子句去扩展一个协议
extension Container where ItemType: Equatable {
    func startsWith(_ item: ItemType) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42")
} else {
    print("Starts with something else.")
}

extension Container where ItemType == Double {
    
    func average() -> Double {
        var sum = 0.0
        for index in 0 ..< count {
            
            sum += self[index]
        }
        return sum / Double(count)
    }
}

print([126.0, 1200.0, 98.6, 37.0].average())

// 具有泛型 where 子句的关联类型

protocol ContainerTT {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    
    func makeIterator() -> Iterator
}
