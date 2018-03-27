//
//  Share.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 29.01.18.
//  Copyright © 2018 Sasha Prokhorenko. All rights reserved.
//

enum Share {
	static func twitterMessage(_ text: String) -> URL {
		let tweet = "https://twitter.com/intent/tweet?text=Just%20cleared%20"
							+ "\(text.urlEncode())%20of%20space%20on%20my%20disk%20thanks%20"
							+	"to%20Sketch%20Cache%20Cleaner!%20Check%20it%20out:%20"
							+ "https%3A%2F%2Fyo-op.github.io%2Fsketchcachecleaner%2F%0A"
		guard let url = URL(string: tweet) else {
			return URL(string: Environment.webPage)!
		}
		return url
	}

	static func facebookMessage(_ text: String) -> URL {
		let facebook = "https://www.facebook.com/dialog/share?%20app_id=1778148252492778" +
			"&href=https%3A%2F%2Fyo-op.github.io%2Fsketchcachecleaner%2F%0A" +
			"&quote=Just%20cleared%20" +
			"\(text.urlEncode())%20of%20space%20on%20my%20disk%20thanks%20" +
			"to%20Sketch%20Cache%20Cleaner!%20Check%20it%20out:%20" +
		"&redirect_uri=https%3A%2F%2F.facebook.com"
		guard let url = URL(string: facebook) else {
			return URL(string: Environment.webPage)!
		}
		return url
	}
}
