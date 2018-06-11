//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var shoppingList = ["catfish", "water", "tulips", "blue paint"]

shoppingList[1] = "bottle of water"//替换

var occupations = [
    "Malcolm" : "Captain",
    "Kaylee" : "Mechanic",
]
occupations["Jayne"] = "Public Relations"//增加

//创建空的数组或字典
let emptyArray = [String]()
let emptyDictionary = [String : Float]()

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore)

var optionalString: String? = "Hello"

print(optionalString == nil)

var optionalName: String? = "John Applesead"

var greeting = "Hello!"

if let name = optionalName {
    greeting = "Hello,\(name)"
}

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeing = "Hi \(nickName ?? fullName)"

//switch支持任意类型的数据以及各种比较操作

let vegetable = "red pepper"

switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber","watecress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)")
default:
    print("Everything tastes good in soup.")
}

//for in 遍历 字典
let interestingNumbers = [
    "Prime": [2,3,4,5,11,13],
    "Fibonacc": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25],
]

var largest = 0
var largestKey: String?
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKey = kind
        }
    }
}

//使用 while or  repeat...while 循环
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100

print(m)

var total = 0
for i in 0..<4 {//不包含上界，若想包含使用 ...
    total += i
}
print(total)

//函数
/**
 使用 func 来声明一个函数，使用名字和参数来调用函数，使用 ->来指定函数返回值的类型
 */
func greet(person: String,day: String) -> String {
    return "Hello \(person),today is \(day)."
}

greet(person: "Bob", day: "Thuesday")

func eat(person: String, food: String) -> String {
    return "Hello \(person), I eat The \(food)"
}

eat(person: "John", food: "orange")

func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)"
}

greet("John", on: "Wednesday")

//元祖
// 可以使用元组来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。

func calculateStatistics(scores:[Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        
        sum += score
    }
    
    return (min,max,sum)
}

let statistics = calculateStatistics(scores: [4,5,6,110,6])

print(statistics.sum)
print(statistics.2)

//函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式：
func sumOf(numbers:Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    
    return sum
}

func sumOf(numbers: [Int]) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    
    return sum
}

sumOf()
sumOf(numbers: 43,66,67)

func average(numbers: [Int]) -> Double {

    let sum = sumOf(numbers: numbers)
    
    return Double(sum / numbers.count)
}

//函数的嵌套
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    
    return y
}

//函数作为返回值
func makeIncrementer() -> ((Int) -> Int) {
    
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

var increment = makeIncrementer()
increment(7)

//函数也可以当做参数传入另一个函数
func hasAnyMatches(list: [Int], condition:(Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    
    return false
}

func lessThanTen(number: Int) -> Bool {
    
    return number < 10
}

var numbers = [10,17,5,13]

hasAnyMatches(list: numbers, condition: lessThanTen)

//闭包
//你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离。
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    
    return result
})

numbers.map({
    (number: Int) -> Int in
    
    if (number % 2) == 0 {
        return number
    } else {
        return 0
    }
    
})

//单个语句的闭包会把它语句的值当做结果返回

let mappedNunbers = numbers.map({number in 3 * number})

print(mappedNunbers)

//通过参数位置而不是参数名字来引用参数——这个方法在非常短的闭包中非常有用。当一个闭包作为最后一个参数传给一个函数的时候，它可以直接跟在括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略括号。

let sortedNumbers = numbers.sorted { $0 > $1}











