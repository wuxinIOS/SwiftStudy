//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//数组(Arrays)
// Array<Element>和[Element]功能上是一样的

// 创建一个空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)
someInts = []

// 带默认值的数组
 var threeDoubles = Array(repeating: 0.9, count: 3)

// 通过两个数组相加创建一个数组
var anotherThreeDouble = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + threeDoubles

// 用数组字面量构造数组
var shoppingList = ["Eggs", "Milk"]

// 访问和修改数组
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate", "Cheese", "Butter"]

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
//利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的
shoppingList[4...6] = ["Bananas", "Apples"]
// 调用数组的insert(_:at:)方法来在某个具体索引值之前添加数据项：
shoppingList.insert("Maple Syrup", at: 0)

shoppingList.remove(at: 0)
shoppingList.removeLast()

// 数组的遍历
for item in shoppingList {
    print(item)
}
for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}

//集合 (Sets)
// 集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
// 语法
// 只能通过Set<Element>来创建
var letters = Set<Character>()
letters.index(of: "a")
letters = []

// 用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// 一个Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
print("I have \(favoriteGenres.count) favorite music genres.")

favoriteGenres.insert("Jazz")
// 通过调用Set的remove(_:)方法去删除一个元素，如果该值是该Set的一个元素则删除该元素并且返回被删除的元素值,否则如果该Set不包含该值，则返回nil
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")

}

// 遍历
for genre in favoriteGenres {
    print("\(genre)")
}

// Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.
for genre in favoriteGenres.sorted() {//升序排序来遍历
    print("\(genre)")
}

//集合操作
/**
 使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。--交集
 使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 使用union(_:)方法根据两个集合的值创建一个新的集合。//并集
 使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。
 */
let oddDigits: Set = [1, 3, 5, 7, 9]

let evenDigits: Set = [0, 2, 4, 6, 8]

let singleDigits: Set = [2, 3, 5, 7]

oddDigits.intersection(evenDigits).sorted()//[]

oddDigits.symmetricDifference(singleDigits).sorted()//[1, 2, 9]

oddDigits.union(evenDigits).sorted()//[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

oddDigits.subtracting(singleDigits).sorted()//[1, 9]

/**
 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
 */


//字典[key: value]
var namesOfIntegers = [Int: String]()//创建空字典
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty")
}

airports["LHR"] = "London"

airports["LHR"] = "London Heathrow"

// updateValue(_:forKey:)返回更新之前的原值，是可选的。若之前有值，就更新原值，若没有，则新增，返回nil值
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

airports["APL"] = "Apple Internation"

airports["APL"] = nil

//removeValue(forKey:)方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回nil：

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)")
} else {
    print("The airports dictionary does not contain a value for DUB")
}

//字典遍历
for (airportCode, airportName) in airports {
    print("\(airportCode):\(airportName)")
}

for airportCode in airports.keys {
    print("Airport code:\(airportCode)")
}

for airportName in airports.values {
    print("Airport name:\(airportName)")
}

let airportCode = [String](airports.keys)











