//
//  FormRowView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/6/25.
//

import SwiftUI

struct FormRowView: View {
	
	
	// MARK: - properties
	
	var firstItem: String
	var secondItem: String
	
	// MARK: - body
	
	var body: some View {
		HStack {
			Text(firstItem)
				.foregroundColor(.gray)
			
			Spacer()
			
			Text(secondItem)
		} // HStack
	}
}


// MARK: - preview

#Preview {
	FormRowView(firstItem: "Application", secondItem: "Slot Machine")
}
