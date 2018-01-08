//
//  NSButtonExtensions.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 19.12.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa

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
	
	@discardableResult
	static func setButton(_ button: NSButton, title: String)  -> NSButton {
		button.title = title
		button.cornerRadius = 3.0
		button.backgroundColor = NSColor(red:1.0, green:0.70, blue:0.0, alpha:1.00)
		let textColor =  NSColor(red:1.0, green:1.0, blue:1.0, alpha:1.00)
		
		let style = NSMutableParagraphStyle()
		style.alignment = .center

		let font = NSFont.mainFont(ofSize: 14)
		let attributes = [NSAttributedStringKey.foregroundColor: textColor,
											NSAttributedStringKey.font: font,
											NSAttributedStringKey.paragraphStyle: style] as [NSAttributedStringKey : Any]
		
		button.attributedTitle = NSAttributedString(string: title, attributes: attributes)
		return button
	}
}
