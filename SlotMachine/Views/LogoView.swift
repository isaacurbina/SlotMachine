//
//  LogoView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/2/25.
//

import SwiftUI

struct LogoView: View {
	
	
	// MARK: - body
	
	var body: some View {
		Image("gfx-slot-machine")
			.resizable()
			.scaledToFit()
			.frame(minWidth: 256, idealWidth: 300, maxWidth: 320, minHeight: 112, idealHeight: 130, maxHeight: 140, alignment: .center)
			.padding(.horizontal)
			.layoutPriority(1)
			.modifier(ShadowModifier())
	}
}


// MARK: - preview

#Preview {
	LogoView()
}
