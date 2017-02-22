//
//  main.swift
//  Typed Protocol
//
//  Created by Ariel Elkin on 22/02/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import Foundation

protocol Observable {
    mutating func add(observer: Observer)
}

protocol Observer {
    func receive(event: Event)
}

struct Event {
    var string: String
}

struct Subject: Observable {

    var observers = [Observer]()

    mutating func add(observer: Observer) {
        observers.append(observer)
    }

    func receive(event: Event) {
        print("Received: \(event)")
    }

    func fireEvent(event: Event) {
        for observer in observers {
            observer.receive(event: event)
        }
    }
}

struct EventReceiver: Observer {
    func receive(event: Event) {
        print("Received: \(event)")
    }
}

var gen = Subject()
let receiver = EventReceiver()

gen.add(observer: receiver)
gen.fireEvent(event: Event.init(string: "hello"))
gen.fireEvent(event: Event.init(string: "hello"))


