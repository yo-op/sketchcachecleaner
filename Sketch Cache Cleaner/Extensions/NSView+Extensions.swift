//
//  NSViewExtensions.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 19.12.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let colorRef = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: colorRef)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}
