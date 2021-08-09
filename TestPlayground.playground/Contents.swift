import Cocoa

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

func makeCounter() -> () -> Int {
    var counter = 0
    return {
        counter += 1
        return counter
    }
}

var test = makeCounter()

test()
test()
test()

