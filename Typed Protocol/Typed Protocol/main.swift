//
//  main.swift
//  Typed Protocol
//
//  Created by Ariel Elkin on 22/02/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import Foundation

protocol Subject {
    mutating func add(observer: Observer)
    mutating func remove(observer: Observer)
}

protocol Observer: class {
    func receive(event: Event)
}

protocol Event {
}

protocol EventWithString: Event {
    var string: String { get }
}

protocol EventWithInt: Event {
    var int: Int { get }
}

struct MyStringEvent: EventWithString {
    let string: String
}

struct MyIntEvent: EventWithInt {
    let int: Int
}

struct ConcreteSubject: Subject {

    var observers = [Observer]()

    mutating func add(observer: Observer) {
        observers.append(observer)
    }
    mutating func remove(observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }

    func fireEvent(event: Event) {
        for observer in observers {
            observer.receive(event: event)
        }
    }
}



class ConcreteObserver: Observer {

    func receive(event: Event) {
        if let e = event as? EventWithInt {
            print("Received an int event: \(e.int)")
        }
        else if let e = event as? EventWithString {
            print("Received a string event: \(e.string)")
        }
    }
}


var subject = ConcreteSubject()
let observer = ConcreteObserver()

subject.add(observer: observer)

subject.fireEvent(event: MyStringEvent(string: "hello"))
subject.fireEvent(event: MyIntEvent(int: 32))
subject.remove(observer: observer)

