//
//  AppDelegate.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 2/6/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa
import Sentry

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        configureSentry()
    }

    fileprivate func configureSentry() {
        do {
            Client.shared = try Client(dsn: Environment.sentry)
            try Client.shared?.startCrashHandler()
        } catch _ {}
    }
}
