//
//  ContentView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/2/25.
//

import SwiftUI

struct ContentView: View {
	
	
	// MARK: - properties
	
	
	
	
	// MARK: - body
	
	var body: some View {
		ZStack {
			
			
			// MARK: - background
			
			LinearGradient(
				gradient: Gradient(
					colors: [Color("ColorPink"), Color("ColorPurple")]),
				startPoint: .top,
				endPoint: .bottom
			)
			.edgesIgnoringSafeArea(.all)
			
			
			// MARK: - interface
			
			VStack(alignment: .center, spacing: 5) {
				
				
				// MARK: - header
				
				LogoView()
				Spacer()
				
				
				// MARK: - score
				
				HStack {
					HStack {
						Text("Your\nCoins".uppercased())
							.scoreLabelStyle()
							.multilineTextAlignment(.trailing)
						
						Text("100")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
						
					} // HStack
					.modifier(ScoreContainerModifier())
					
					Spacer()
					
					HStack {
						Text("200")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
						
						Text("High\nScore".uppercased())
							.scoreLabelStyle()
							.multilineTextAlignment(.leading)
						
					} // HStack
					.modifier(ScoreContainerModifier())
				}
				
				Spacer()
				
				
				// MARK: - slot machine
				
				VStack(alignment: .center, spacing: 0) {
					
					
					// MARK: - reel no. 1
					
					ZStack {
						ReelView()
						Image("gfx-bell")
							.resizable()
							.modifier(ImageModifier())
					} // ZStack
					
					HStack(alignment: .center, spacing: 0) {
						
						
						// MARK: - reel no. 2
						
						ZStack {
							ReelView()
							Image("gfx-seven")
								.resizable()
								.modifier(ImageModifier())
						} // ZStack
						
						Spacer()
						
						
						// MARK: - reel no. 3
						
						ZStack {
							ReelView()
							Image("gfx-cherry")
								.resizable()
								.modifier(ImageModifier())
						} // ZStack
						
					} // HStack
					.frame(maxWidth: 500)
					
					// MARK: - spin button
					
					Button(action: {
						print("Spin the reels")
					}) {
						Image("gfx-spin")
							.renderingMode(.original)
							.resizable()
							.modifier(ImageModifier())
					}
					
					
				} // VStack
				.layoutPriority(2)
				
				
				// MARK: - footer
				
				
			} // VStack
			
			
			// MARK: - buttons
			
			.overlay(
				// reset
				Button(action: {
					print("Reset the game")
				}) {
					Image(systemName: "arrow.2.circlepath.circle")
				}
					.modifier(ButtonModifier()),
				alignment: .topLeading
			)
			.overlay(
				// info
				Button(action: {
					print("Info View")
				}) {
					Image(systemName: "info.circle")
				}
					.modifier(ButtonModifier()),
				alignment: .topTrailing
			)
			.padding()
			.frame(maxWidth: 720)
			
			
			// MARK: - popup
			
			
		} // ZStack
	}
}


// MARK: - preview

#Preview {
	ContentView()
}
