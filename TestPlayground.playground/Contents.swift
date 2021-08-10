import Cocoa

// Lambdas

func travel(to place: String, action: (String, (Int, String)) -> String) {
    print("Going out...")
    let text = action("London", (Int.random(in: 50...70), "km/h"))
    print(text)
    print("Done!")
}

travel(to: "London") { place, speed in
    return "Moving to \(place) with speed \(speed.0) \(speed.1)"
}


func makeMultiplier(by multiplier: Int) -> (Int) -> Int {
    return { num in
        num * multiplier
    }
}

let mul2 = makeMultiplier(by: 2)
print(mul2(5))

// Structs

struct Sport {
    var name: String {
        didSet {
            changes += 1
        }
    }
    var isOlynpic: Bool
    private(set) var changes: Int = 0
    
    var olympicStatus: String {
        isOlynpic ? "olympic" : "not olympic"
    }
}

var tennis = Sport(name: "Tennis", isOlynpic: true)

tennis.olympicStatus
tennis.changes

tennis.name = "Table tennis"
tennis.changes

struct User {
    var name: String
    init(name: String) {
        print("Created user \(name)")
        self.name = name
    }
}

var user = User(name: "Test")

enum StackError : Error {
    case empty
    case notDropable
}

// Classes

class Stack {
    var item: String
    var count: Int
    
    init(item: String, count: Int) {
        self.item = item
        self.count = count
    }
    
    deinit {
        print("x\(count) \(item) is no more")
    }
    
    func drop() throws {
        if count <= 0 {
            throw StackError.empty
        }
        print("\(item) dropped")
        count -= 1
    }
}

class PenStack: Stack {
    init(count: Int) {
        super.init(item: "Pen", count: count)
    }
    
    override func drop() throws {
        throw StackError.notDropable
    }
}



func dropAll(from stack: Stack) {
    while true {
        do {
            try stack.drop()
        } catch {
            print("Error \(error)")
            break
        }
    }
}

let test = {
    let penStack = PenStack(count: 5)
    let pencilStack = Stack(item: "Pencil", count: 5)
    
    dropAll(from: penStack)
    dropAll(from: pencilStack)
}
test()

// Protocols

protocol Identifiable {
    var id: String { get set }
    func displayId()
}

extension Identifiable {
    func displayId() {
        print("Id: \(id)")
    }
}

protocol Nameable {
    var name: String { get set }
}

struct IdUser: Identifiable, Nameable {
    var name: String
    var id: String
}

let iuser = IdUser(name: "Test", id: "1")
iuser.displayId()
