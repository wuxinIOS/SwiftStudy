//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
// 类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例
// 类型转换在swift中使用 is 和 as 操作符实现，分别检查值的类型或者转换它的类型
// 也可以用它来检查一个类型是否实现了某个协议。

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var aritsts: String
    init(name: String, artists: String) {
        self.aritsts = artists
        super.init(name: name)
    }
    
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artists: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The one And only", artists: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artists: "Rick Astley")
]

// 类型检查
// 类型检查符：is 来检查一个实例是否属于特定子类型。
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Medis library contains \(movieCount) movies and \(songCount) songs")


// 向下转型
// 某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。

for itme in library {
    if let movie = itme as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = itme as? Song {
        print("Song: '\(song.name)', by \(song.aritsts)")
    }
}


// Any 和 AnyObject的类型转换
// swift为不确定类型提供了两种特殊的类型别名
// · Any可以表示任何类型，包括函数类型
// · AnyObject可以表示任何类类型的实例
// 只有当你确实需要他们的行为和功能时才使用 Any 和 AnyObject。
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I won't to print")
    case let someString as String:
        print("a string value of \(someString)")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
