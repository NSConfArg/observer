//
//  main.swift
//  NotificationCenter
//
//  Created by Ariel Elkin on 03/03/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import Foundation

let notificationName = NSNotification.Name(rawValue: "name")

class Observer {
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receiveNotification(notification:)),
            name: notificationName,
            object: nil
        )
    }

    @objc public func receiveNotification(notification: Notification) {
        if let number = notification.userInfo?["foo"] {
            print("number: \(number)")
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
    }
}

class Subject {
    func sendNotification() {
        NotificationCenter.default.post(
            name: notificationName,
            object: nil,
            userInfo: ["foo": 42]
        )
    }
}

let s = Subject()
var o = Observer()

s.sendNotification() // number: 42
