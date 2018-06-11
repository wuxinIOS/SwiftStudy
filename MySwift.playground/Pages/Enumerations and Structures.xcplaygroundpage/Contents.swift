//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//使用enum来创建一个枚举。像类和其他所有命名类型一样，枚举可以包含方法
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue
//默认情况下，Swift 按照从 0 开始每次加 1 的方式为原始值进行赋值，不过你可以通过显式赋值进行改变。在上面的例子中，Ace 被显式赋值为 1，并且剩下的原始值会按照顺序赋值。你也可以使用字符串或者浮点数作为枚举的原始值。使用 rawValue 属性来访问一个枚举成员的原始值。
//使用 init?(rawValue:) 初始化构造器来创建一个带有原始值的枚举成员。如果存在与原始值相应的枚举成员就返回该枚举成员，否则就返回 nil。

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescripion() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades:
            return "black"
        case .clubs:
            return "black"
        default:
            return "red"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescripion()

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let faulure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure....\(message)")
    
}

//使用 struct 来创建一个结构体。结构体和类有很多相同的地方，比如方法和构造器。它们之间最大的一个区别就是结构体是传值，类是传引用。
//结构体
struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescripion() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescripion())"
    }
    
    func creatCard() -> String {
        
       return ""
        
    }
    
}

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescripion()













