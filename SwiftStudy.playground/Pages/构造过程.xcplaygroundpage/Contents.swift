//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 构造过程
// 构造过程是使用类、结构体或枚举类型的实例之前的准备过程。在新实例可用前必须执行这个过程，具体操作包括设置实例中每个存储属性的初始值和执行其他必须的设置或初始化工作

// 存储属性的初始赋值
// 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储属性的值不能处于一个未知的状态.
// 当你为存储属性设置默认值或者在构造器中为其赋值时，他们的值是被直接设置的，不会触发任何属性观察者。

// 构造器
// 构造器在创建某个特定类型的新实例时被调用。
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")
// 默认属性值
// 可以在构造器中为存储属性设置初始值。同样，你也可以在属性声明时为其设置默认值
/**
     struct Fahrenheit {
         var temperature = 32.0
         init() {
         }
     }
 */

// 自定义构造过程
// 可以通过输入参数和可选类型的属性来自定义构造过程，也可以在构造过程中修改常量属性。
// 构造参数
struct Celsius {
    var temperatureInCelsius: Double
    
    init(formFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(formFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let hafGray = Color(white: 0.5)

//不带外部名的构造器参数
let bodyiTemperature = Celsius(37.0)

// 可选属性类型
class SurveyQuestion {
    let text: String
    
    var response: String?
    
    init(text: String) {
        self.text = text//在构造器中是可以修改常量属性的值
    }
    func ask()  {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
print(cheeseQuestion.response ?? "NO")

// 构造过程中常量属性的修改
// 可以在构造过程中的任意时间点给常量属性呢指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改
// 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改，不能在子类中修改


// 默认构造器
// 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
class ShoppingListItemT {
    var name: String?
    var quantity = 1
    var purchased = false
}

// 结构体的逐一成员构造器
// 除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)

// 值类型的构造器代理
// 构造器可以通过调用其他构造器来完成实例的部分构造过程。这一过程称为构造器代理，他能减少过个构造器间的重复代码。

// 对于值类型，你可以使用self.init在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用self.init。

// 如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用自动生成的构造器
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size =  Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originy = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originy), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

// 类的继承和构造过程
// 类里面的所有存储属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值
// swift为类类型提供了两种构造器来确保实例中所有存储属性都能获得初始值，它们分别是指定构造器和便利构造器。
// 指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
// 每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。
// 定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
// 语法：
/**
 便利构造器：
     convenience init(parameters) {
        statements
    }
 */
//类的构造器代理规则:
// 1.指定构造器必须调用其直接父类的指定构造器
// 2.便利构造器必须调用同类中定义的其他构造器
// 3.便利构造器必须最终导致一个指定构造器被调用
// 总结就是：指定构造器必须总是向上代理，便利构造器必须总是横向代理

// 两段式构造过程
// 第一个阶段：每个存储属性被引入他们的类指定一个初始值，当每个存储属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制他们的存储属性。
// 安全检查：
// 1.指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其他构造任务向上代理给父类中的构造器
// 2.指定构造器必须向上代理调用父类构造器，然后再为继承的属性设置新值。如果没有那么做指定构造器赋予的新值将被父类中的构造器所覆盖。
// 3.遍历构造器必须先代理调用同一类中的其他构造器，然后再为任意属性赋新值。如果没那么做，遍历构造器赋予的新值将被同一类中其他指定构造器所覆盖
// 4.构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何属性的值，不能引用self作为一个值。

// 阶段1：
// 1.某个指定构造器或便利构造器被调用.
// 2.完成新实例内存的分配，但此时内存还没有被初始化。
// 3.指定构造器确保其所有在类引入的所有存储属性都已赋初值。存储型属性所属的内存完成初始化。
// 4.指定构造器将调用父类的构造器，完成父类属性的初始化
// 5.这个调用父类构造器的过程沿着构造链一直往上执行，直到到达构造器链的最顶部。
// 6.当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完成初始化。此时阶段1完成.

// 阶段2：
// 1.从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
// 2.最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。


// 构造器的继承和重写
// Swift中的子类默认情况下不会继承父类的构造器。

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    convenience init(numberOfWheels: Int) {
        self.init()
        self.numberOfWheels = numberOfWheels
    }
    
    init() {
        numberOfWheels = 0
    }
    init(number: Int) {
        numberOfWheels = number
    }
}

let vehicle = Vehicle(numberOfWheels: 0)
print("Vehicle:\(vehicle.description)")

class Bicycel: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
    override init(number: Int) {
        super.init(number: number)
        numberOfWheels = 2
    }
}

let bicycel = Bicycel()
print("Bicycle: \(bicycel.description)")


//子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。

// 构造器的自动继承
// 假设为子类中引入的所有新属性都提供了默认值，以下2个规则适用：
// 1.如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器.
// 2.如果子类提供了所有父类指定构造器的实现--无论是通过规则1继承过来的，还是提供了自定义实现--它将自动继承所有父类的便利构造器.

// 指定构造器和便利构造器实践

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let nameMeat = Food(name: "Bacon")
// Food类中的构造器init(name: String)被定义为一个指定构造器，因为它能确保Food实例所有存储型属性都被初始化。Food类没有父类，所以init(name: String)构造器不需要调用super.init()来完成构造过程.
// Food类同样提供了一个没有参数的便利构造器init()。这个init()构造器为新食物提供了一个默认的占位名字，通过横向代理到指定构造器init(name: String)并给参数name传值[Unnamed]来实现
let mysterMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysterItem = RecipeIngredient()

let ontBacon = RecipeIngredient(name: "Bacon")

let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "" : ""
        return output
    }
    
}


