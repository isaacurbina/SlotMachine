//
//  InfoView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/6/25.
//

import SwiftUI

struct InfoView: View {
	
	
	// MARK: - properties
	
	@Environment(\.presentationMode) var presentationMode
	
	
	// MARK: - body
	
	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			LogoView()
			
			Spacer()
			
			Form {
				Section(header: Text("About the application")) {
					FormRowView(firstItem: "Application", secondItem: "Slot Machine")
					FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
					FormRowView(firstItem: "Developer", secondItem: "Isaac Urbina")
					FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
					FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
					FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
					FormRowView(firstItem: "Copyright", secondItem: "© 2025 Isaac Urbina")
					FormRowView(firstItem: "Version", secondItem: "1.0.0")
				}
			}
			.font(.system(.body, design: .rounded))
			
		} // VStack
		.padding(.top, 40)
		.overlay(
			Button(action: {
				audioPlayer?.stop()
				presentationMode.wrappedValue.dismiss()
			}) {
				Image(systemName: "xmark.circle")
					.font(.title)
			}
				.padding(.top, 30)
				.padding(.trailing, 20)
				.accentColor(Color.secondary)
			, alignment: .topTrailing
		)
		.onAppear {
			playSound(sound: "background-music", type: "mp3")
		}
	}
}


// MARK: - preview

#Preview {
	InfoView()
}
