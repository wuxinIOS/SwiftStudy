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






























