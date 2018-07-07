//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 表示并抛出错误
// 在swift中，错误用符合Error协议的类型的值来表示。这个空协议表明该类型可以用于错误处理
enum VendingMachineError: Error {
    case invalidSelection   //选择无效
    case insufficientFunds(coinsNeeded: Int)//金额不足
    case outOfStock // 缺货
}

// Swift中有4中处理错误的方式
// 1.把函数抛出的错误传递给调用此函数的代码
// 2.用do-catch语句处理错误
// 3.将错误作为可选类型处理
// 4.断言此错误根本不会发生

// 用throwing函数传递错误
// 为了表示一个函数、方法或构造器可以抛出错误，在函数申明的参数列表之后加上throws关键字，一个标有throws关键字的函数被称为throwing函数，如果这个函数指明了返回值类型，throws关键字需要写在(->)的前面
// func canThrowErros() throws -> String
// func cannotThrowErros() -> String
// 一个throwing函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域
// 注意：只有throwing函数可以传递错误。任何在某个非throwing函数内部抛出的错误只能在函数内部处理

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispending \(name)")
    }
}
// 因为vend(itemName:)方法会传递出它抛出的任何错误，在代码中调用此方法的地方，必须要么直接处理这些错误--使用do-catch语句，try?或try!;要么继续将这些错误传递下去。
// buyFavoriteSnack(person:vendingMachine:)同样是一个throwing函数，任何由vend(itemNamed:)方法抛出的错误会一直被传递到buyFavoriteSnack(person:vendingMachine:)函数被调用的地方
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

// buyFavoriteSnack(person:vendingMachine:)函数会查找某人最喜欢的零食，并通过调用vend(itemNamed:)方法来尝试为他们购买。因为vend(itemNamed:)方法能抛出错误，所以在调用的它时候在它前面加了try关键字。

struct PurchasedSnack {
    let name: String
    init(name: String,vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// 用Do-Catch处理错误
// 一般形式：
/**
     do {
        try expression
     } catch pattern 1 {
 
     } catch pattern 2 where condition {
 
     }
 */
// 在catch后面写一个匹配模式来表明这个子句能处理什么样的错误。如果一条catch子句没有指定匹配模式，那么这条子句可以匹配任何错误，并且把错误绑定到一个名字为error的局部常量。关于模式匹配的更多信息请参考 模式。

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock  {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}

// 将错误转换成可选值
// 可以使用try?通过将错误转换成一个可选值来处理错误.
// 如果在评估try?表达式时一个错误被抛出，那么表达式的值就是nil。例如，在下面的代码中，x和y有着相同的数值和等价的含义：
/**
func someThrowingFunction() throws -> Int {
    
}

let x = try? someThrowingFunction()

 
 let y: Int?
 do {
    y = try someThrowingFunction()
 } catch {
    y = nil
 }

*/
//如果someThrowingFunction()抛出一个错误，x和y的值是nil。否则x和y的值就是该函数的返回值。注意，无论someThrowingFunction()的返回值类型是什么类型，x和y都是这个类型的可选类型。
/**
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
 */


// 禁用错误传递
// 有时你知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。
// 例如，下面的代码使用了loadImage(atPath:)函数，该函数从给定的路径加载图片资源，如果图片无法载入则抛出一个错误。在这种情况下，因为图片是和应用绑定的，运行时不会有错误抛出，所以适合禁用错误传递。
// let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
