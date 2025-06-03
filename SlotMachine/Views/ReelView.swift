//
//  ReelView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/3/25.
//

import SwiftUI

struct ReelView: View {
	
	
	// MARK: - body
	
	var body: some View {
		Image("gfx-reel")
			.resizable()
			.modifier(ImageModifier())
	}
}


// MARK: - preview

#Preview {
	ReelView()
}
