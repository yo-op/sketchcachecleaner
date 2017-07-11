//
//  Extensions.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 4/17/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//
import Foundation
import Cocoa

extension NSView {
  var backgroundColor: NSColor? {
    get {
      guard let colorRef = self.layer?.backgroundColor else { return nil }
      return NSColor(cgColor: colorRef)
    }
    set {
      self.wantsLayer = true
      self.layer?.backgroundColor = newValue?.cgColor
    }
  }
}


extension NSButton {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer!.cornerRadius
    }
    set {
      layer?.cornerRadius = newValue
      layer?.masksToBounds = newValue > 0
    }
  }
}


extension String {
  func trim() -> String {
    return self.trimmingCharacters(in: CharacterSet.whitespaces)
  }
}
