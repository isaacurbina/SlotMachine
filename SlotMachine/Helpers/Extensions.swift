//
//  Extensions.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/2/25.
//

import SwiftUI

extension Text {
	func scoreLabelStyle() -> Text {
		self
			.foregroundColor(.white)
			.font(.system(size: 10, weight: .bold, design: .rounded))
	}
	
	func scoreNumberStyle() -> Text {
		self
			.foregroundColor(.white)
			.font(.system(.title, design: .rounded))
			.fontWeight(.heavy)
	}
}
