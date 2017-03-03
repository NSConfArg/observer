//
//  main.swift
//  Protocol
//
//  Created by Ariel Elkin on 21/02/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import Foundation

protocol Observable {
    mutating func add(observer: Observer)
}


protocol Observer {
    func receive(event: Any)
}

struct Subject: Observable {
    var observers: [Observer] = []

    mutating func add(observer: Observer) {
        observers.append(observer)
    }

    func fireEvents(event: Any) {
        for observer in observers {
            observer.receive(event: event)
        }
    }
}

struct EventReceiver: Observer {
    func receive(event: Any) {
        print("Received: \(event)")
    }
}

var gen = Subject()
let receiver = EventReceiver()

gen.add(observer: receiver)
gen.fireEvents(event: "hi!")
gen.fireEvents(event: 42)
