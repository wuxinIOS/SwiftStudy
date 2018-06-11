//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// 字符串字面量
let someString = "Some string literal value"
// someString常量通过字符串字面量进行初始化

//多行字符串字面量
let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked
"""
//下面两个字符串是一样的
let singleLineString = "There are the same."
let mulitilineString = """
These are the same.
"""
//你的代码中，多行字符串字面量包含换行符的话，则多行字符串字面量中也会包含换行符。如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠(\)作为续行符。
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.
"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

//一个多行字符串字面量能够缩进来匹配周围的代码。关闭引号(""")之前的空白字符串告诉Swift编译器其他各行多少空白字符串需要忽略。然而，如果你在某行的前面写的空白字符串超出了关闭引号(""")之前的空白字符串，则超出部分将被包含在多行字符串字面量中。

//字符串字面量的特殊字符
/**
 字符串字面量可以包含以下特殊字符：
 · 转义字符\(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\"(双引号)、\'(单引号)
 · Unicode标量，写成\u{n}(u为小写),其中n为任意一到八位十六机制数且可用的Unicode位码
 */
let wiseWords = "\"Imagination is more importan than knowlede\" - Einstein"
let dollarsign = "\u{24}"
let spartlinegHeart = "\u{1F496}"
let blackHeart = "\u{2665}"

//初始化空字符串
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

//字符串可变性
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander"

//字符串是值类型
// 当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。任何情况下，都会对已有字符串创建新副本，并对改新副本进行传递或赋值操作。

//使用字符
//使用for-in循环来遍历字符串,获取字符串中每一个字符的值：
for charater in "Dog!🐶" {
    print(charater)
}
// 通过标明一个Character类型并用字符字面量进行赋值，可以建立一个独立的字符常量或变量：
let exclamationMark: Character = "!"
let exclamationMarkString = "!"

//字符串可以通过一个值类型为character的数组作为自变量来初始化
let catCharaters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharaters)
print(catString)

//连接字符串和字符

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

//使用 append()方法将一个字符附加到一个字符串变量的尾部
let exclamationMarkC: Character = "!"
welcome.append(exclamationMarkC)

let badStart = """
one
two

"""

let end = """
three
"""

print(badStart + end)

//字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// Unicode标量
let a = "\u{0061}"
let jj = "\u{1F425}"

let e = "\u{0065}\u{0301}"

let eAcute: Character = "\u{E9}"

let combinedEAcute: Character = "\u{65}\u{301}"

let precomposed: Character = "\u{D55c}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"

let enclosedEAcute: Character = "\u{E9}\u{20DD}"

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")

word += "\u{301}"

print("the number of characters in \(word) is \(word.count)")


//访问和修改字符串
// 字符串索引
// 使用 startIndex 属性可以获取一个 String 的第一个 Character的确定位置.
// 使用 endIndex 属性可以获取最后一个Character的后一个位置的索引.
let greeting = "Guten Tag!"
greeting[greeting.startIndex]//G
greeting[greeting.index(before: greeting.endIndex)]//!
greeting[greeting.index(after: greeting.startIndex)]//u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

//使用indices属性会创建一个包含全部索引的范围(Range),用来在一个字符串中访问单个字符
for index in greeting.indices {
    print("\(greeting[index]) ",terminator:"")//G u t e n T a g !
}

// 插入和删除
// 调用 insert(_:at:)方法可以下一个字符串的指定索引插入一个字符，调用insert(contentsOf:at:)方法可以在一个字符串的指定索引插入一段字符串
var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
welcome1.insert(contentsOf: " there", at: welcome1.index(before: welcome1.endIndex))

welcome1.remove(at: welcome1.index(before: welcome1.endIndex))

let range = welcome1.index(welcome1.endIndex, offsetBy: -6)..<welcome1.endIndex
welcome1.removeSubrange(range)

// 子字符串
// 注意：  String 和 SubString 的区别在于性能优化上，SubString 可以重用原 String 的内存空间
// 下面的列子中，greeting 是一个 String，意味着它在内存里有一片空间保存字符集。而由于 beginning 是 greeting 的 SubString，它重用了 greeting 的内存空间。相反，newString 是一个 String —— 它是使用 SubString 创建的，拥有一片自己的内存空间
let greetingA = "Hello, world!"
let indexA = greetingA.index(of: ",") ?? greetingA.endIndex
let beginning = greetingA[..<indexA]//Hello
let newStringA = String(beginning)

//比较字符串，提供了三种方式来比较文本：字符串字符相等、前缀相等或后缀相等
// 字符串/字符相等
let quotationA = "We're a lot alike, you and I."
let sameQuotationA = "We're a lot alike, you and I."
if quotation == sameQuotationA {
    print("These two string are considered equal")
}
// 前缀或后缀相等
// 通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值。
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var actqSceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        actqSceneCount += 1
    }
}
print("There are \(actqSceneCount) scenein Act 1")

//字符串的Unicode表现形式









