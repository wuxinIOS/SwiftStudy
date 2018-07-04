//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 使用可选链式调用代替强制展开
// 通过在想调用的属性、方法、或下标的可选值后面放一个问号（?），可以定义一个可选链。
// 为了反映可选链式调用可以在空值（nil）上调用的事实，不论这个调用的属性、方法及下标返回的值是不是可选值，它的返回结果都是一个可选值
class Person {
    var residence: Residence?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIndentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingName != nil && street != nil {
            return "\(buildingName) \(street)"
        } else {
            return nil
        }
    }
    
}

class Residence {
    var rooms = [Room]()
    
    var numberOfRoons: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRoons)")
    }
    
    var address: Address?
}

let john = Person()
// let roomCount = john.residence!.numberOfRoons//会引发运行时错误
if let roomCount = john.residence?.numberOfRoons {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
john.residence = Residence()

if let roomCount = john.residence?.numberOfRoons {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

// 为可选链式调用定义模型类

let andy = Person()
if let roomCount = andy.residence?.numberOfRoons {
    print("Andy's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let somAddress = Address()
somAddress.buildingNumber = "29"
somAddress.street = "Acacia Road"
andy.residence?.address = somAddress

func creatAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    somAddress.buildingNumber = "29"
    somAddress.street = "Acacia Road"
    return someAddress
}

andy.residence?.address = creatAddress()

// 通过可选链式调用调用方法
// 在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是Void?，而不是Void，因为通过可选链式调用得到的返回值都是可选的。
// 即使方法本身没有定义返回值。通过判断返回值是否为nil可以判断调用是否成功：
if andy.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// 可以据此判断通过可选链式调用为属性赋值是否成功
// 我们尝试给john.residence中的address属性赋值，即使residence为nil。通过可选链式调用给属性赋值会返回Void?，通过判断返回值是否为nil就可以知道赋值是否成功：
if (andy.residence?.address = somAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

// 通过可选链式调用 访问下标
if let firstRoomName = andy.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first name.")
}

andy.residence?[0] = Room(name: "Bathroom")

let andyHouse = Residence()
andyHouse.rooms.append(Room(name: "Living Room"))
andyHouse.rooms.append(Room(name: "Kitchen"))
andy.residence = andyHouse

if let firstRoomName = andy.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first name.")
}

// 访问可选类型的下标
var testScores = ["Dave":[86, 82, 84], "Bev": [79, 94, 81]]
testScores["Andy"]?[0] = 90
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
print("\(testScores["Dave"])")

// 连接多层可选链式调用
// 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法、下标。然而，多层可选链式调用不会增加返回值的可选层级
//也就是说：
// 1.如果你访问的值不是可选的，可选链式调用将会返回可选值
// 2.如果访问的值是可选的，可选链式调用不会让可选返回值变得"更可选"
// 因此：
// 1.通过可选链式调用访问一个Int的值，将会返回Int?，无论使用了多少层可选链式调用
// 2.类似的，通过可选链式调用访问Int?值，依旧会返回Int?值，并不会返回Int??。

if let johnStree = andy.residence?.address?.street {
    print("John's street name is \(johnStree)")
} else {
    print("Unable to retrieve the address.")
}

let andyAddress = Address()
andyAddress.buildingName = "The Larches"
andyAddress.street = "Laurel Street"
andy.residence?.address = andyAddress
if let andyStreet = andy.residence?.address?.street {
    print("Andy'st street name is \(andyStreet)")
} else {
    print("Unable to retrieve the address.")
}

// 在方法的可选返回值上进行可选链式调用

if let buildingIdentifier = andy.residence?.address?.buildingIndentifier() {
    print("Andy's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = andy.residence?.address?.buildingIndentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Andy's building identifier begins with \"the\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
