//: Playground - noun: a place where people can play

import UIKit

//extension Int {
//    func plusOne() -> Int {
//        return self + 1
//    }
//}

//var myInt = 0
//myInt.plusOne()
//5.plusOne()

extension Int {
    mutating func plusOne() {
        self += 1
    }
}

var myInt = 10
myInt.plusOne()


//Protocol-oriented programming for beginners

//extension Int {
//    func squared() -> Int {
//        return self * self
//    }
//}

// Rewrite extension
extension Integer {
    func squared() -> Self {
        return self * self
    }
}

let i: Int = 8
print(i.squared())

let j: UInt64 = 8
print(j.squared())