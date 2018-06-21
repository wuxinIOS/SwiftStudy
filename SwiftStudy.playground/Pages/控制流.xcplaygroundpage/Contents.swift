//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

// for-in 遍历

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animaName, legCount) in numberOfLegs {
    print("\(animaName)s have \(legCount) legs")
}

for index in 1...5 {
    print("\(index) time 5 is \(index * 5)")
}

// 使用 stride(from:to:by:) 函数跳过不需要的标记。开区间
// 使用 stride(from:through:by:) 其同样的作用，不过是闭区间
let minutes = 60
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print("tickMark:\(tickMark)")
}

for ticKMark in stride(from: 0, through: minutes, by: minuteInterval) {
    print("TickMark:\(ticKMark)")
}


//While 循环
// 有两种While循环
// while循环，每次在循环开始时计算条件是否符合；
// repeat-while循环，每次在循环结束时计算条件是否符合。
/**
 repeat {
    statements
  } while condition
 */


//条件语句
// if 语句
// switch 语句
/**
 Swift 允许多个 case 匹配同一个值
 如果存在多个匹配，那么只会执行第一个被匹配到的 case 分支
 
 switch some value to consider {
 
 case value 1:
      respond to value 1
 
 case value 2,
      value 3:
      respond to value 2 or 3
 
 default:
     otherwise, do something else
 }
 
 */

let someCharacter: Character = "A"
switch someCharacter {
case "a", "A":
    print("The first letter of the alphabet")
case "z", "Z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

//区间匹配
let approximateCount = 63
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings)")

//元组匹配
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside the box")
}

// 值绑定
//  case 分支允许将匹配的值声明为临时常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑定（value binding
let anotherPoint = (2, 1)

switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with an y value of \(y)")
case (let x, let y):
    print("somewhere else at (\(x), \(y)")
}

//where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x),\(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x),\(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
    
}

// 复合匹配
let anotherCharacter: Character = "e"
switch anotherCharacter {
case "a", "e", "i", "o", "u":
    print("\(anotherCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(anotherCharacter) is a consonant")
default:
    print("\(anotherCharacter) is not a vowel or a consonant")
}


let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")

default:
    print("Not on an axis")
}

// 控制转移语句
// continue、break、fallthrough、return、throw

// continue语句告诉一个循环体立刻停止本次循环，重新开始下次循环
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput {
    switch character {
    case "a","e","i","o","u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

// break语句会立刻结束整个控制流的执行。break 可以在 switch 或循环语句中使用，用来提前结束switch或循环语句。

// fallthrough (贯穿)
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}

print(description)

// 带标签的k语句
// 使用标签（statement label）来标记一个循环体或者条件语句，对于一个条件语句，你可以使用break加标签的方式，来结束这个被标记的语句。对于一个循环语句，你可以使用break或者continue加标签，来结束或者继续这条被标记语句的执行。
// label name: while condition { statements }


// 提前退出
// 使用guard语句来要求条件必须为真时，以执行guard语句后的代码
// guard语句总是有一个else从句，如果条件不为真则执行else从句中的代码。
func greet(person:[String : String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)")

    guard let location = person["location"] else { return
        print("I hope the weather is nice near you.")
    }
    
    print("I hope the weather is nice in \(location)")
    
}

greet(person: ["name": "John"])

greet(person: ["name": "Jane", "location": "Cupertino"])

//检测 API 可用性
/**
 if #available(iOS 10, macOS 10.12, *) {
 // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
 } else {
 // 使用先前版本的 iOS 和 macOS 的 API
 }
 
 */
if #available(iOS 10,iOSMac 10.12, *) {
    print("iOS 10 或 iOSMac 10.12")
} else {
    print("iOS 10以前版本")
}
