//
//  NSFontExtensions.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 19.12.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa

extension NSFont {
	
	private static func customFont(name: String, size: CGFloat) -> NSFont {
		let font = NSFont(name: name, size: size)
		assert(font != nil, "Can't load font: \(name)")
		return font ?? NSFont.systemFont(ofSize: size)
	}
	
	/// Main font
	static func mainFont(ofSize size: CGFloat) -> NSFont {
		return customFont(name: "San Francisco Display Semibold", size: size)
	}

}
