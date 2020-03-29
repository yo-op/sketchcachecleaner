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

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    configureSentry()
  }

    fileprivate func configureSentry() {
        do {
            Client.shared = try Client(dsn: "https://90daa0afc9e04716a579a237e92d021b@sentry.io/5179181")
            try Client.shared?.startCrashHandler()
        } catch let error {
            print(error)
        }
    }
 }
