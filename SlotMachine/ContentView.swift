//
//  ContentView.swift
//  SlotMachine
//
//  Created by Isaac Urbina on 6/2/25.
//

import SwiftUI

struct ContentView: View {
	
	
	// MARK: - properties
	
	@State private var showingInfoView: Bool = false
	@State private var reels: Array = [0, 1, 4]
	@State private var coins: Int = 100
	@State private var highscore: Int = 0
	@State private var betAmount: Int = 10
	@State private var isActiveBet10: Bool = true
	@State private var isActiveBet20: Bool = false
	private let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
	
	
	// MARK: - functions
	
	// spin the reels
	
	private func spinReels() {
		reels = reels.map({ _ in
			Int.random(in: 0...symbols.count - 1)
		})
	}
	
	// check the winning
	
	private func checkWinning() {
		if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
			playerWins()
			if coins > highscore {
				newHighScore()
			}
			
		} else {
			playerLoses()
		}
	}
	
	private func playerWins() {
		coins += betAmount * 10
	}
	
	private func newHighScore() {
		highscore = coins
	}
	
	private func playerLoses() {
		coins -= betAmount
	}
	
	private func activateBet20() {
		betAmount = 20
		isActiveBet10 = false
		isActiveBet20 = true
	}
	
	private func activateBet10() {
		betAmount = 10
		isActiveBet20 = false
		isActiveBet10 = true
	}
	
	// game is over
	
	
	
	
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
						
						Text("\(coins)")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
						
					} // HStack
					.modifier(ScoreContainerModifier())
					
					Spacer()
					
					HStack {
						Text("\(highscore)")
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
						Image(symbols[reels[0]])
							.resizable()
							.modifier(ImageModifier())
					} // ZStack
					
					HStack(alignment: .center, spacing: 0) {
						
						
						// MARK: - reel no. 2
						
						ZStack {
							ReelView()
							Image(symbols[reels[1]])
								.resizable()
								.modifier(ImageModifier())
						} // ZStack
						
						Spacer()
						
						
						// MARK: - reel no. 3
						
						ZStack {
							ReelView()
							Image(symbols[reels[2]])
								.resizable()
								.modifier(ImageModifier())
						} // ZStack
						
					} // HStack
					.frame(maxWidth: 500)
					
					// MARK: - spin button
					
					Button(action: {
						spinReels()
						checkWinning()
					}) {
						Image("gfx-spin")
							.renderingMode(.original)
							.resizable()
							.modifier(ImageModifier())
					}
					
					
				} // VStack
				.layoutPriority(2)
				
				
				// MARK: - footer
				
				HStack {
					
					
					// MARK: - bet 20
					
					HStack(alignment: .center, spacing: 10) {
						Button(action: {
							activateBet20()
						}) {
							Text("20")
								.fontWeight(.heavy)
								.foregroundColor(isActiveBet20 ? .yellow : .white)
								.modifier(BetNumberModifier())
						} // Button
						.modifier(BetCapsuleModifier())
						
						Image("gfx-casino-chips")
							.resizable()
							.opacity(isActiveBet20 ? 1 : 0)
							.modifier(CasinoChipsModifier())
					} // HStack
					
					
					// MARK: - bet 10
					
					HStack(alignment: .center, spacing: 10) {
						Image("gfx-casino-chips")
							.resizable()
							.opacity(isActiveBet10 ? 1 : 0)
							.modifier(CasinoChipsModifier())
						
						Button(action: {
							activateBet10()
						}) {
							Text("10")
								.fontWeight(.heavy)
								.foregroundColor(isActiveBet10 ? .yellow : .white)
								.modifier(BetNumberModifier())
						} // Button
						.modifier(BetCapsuleModifier())
						
					} // HStack
					
					
				} // HStack
				
				
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
					showingInfoView = true
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
		.sheet(isPresented: $showingInfoView) {
			InfoView()
		}
	}
}


// MARK: - preview

#Preview {
	ContentView()
}
