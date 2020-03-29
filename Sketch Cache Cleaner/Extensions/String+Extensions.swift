//
//  StringExtensions.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 19.12.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func urlEncode() -> String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "none"
    }
}
