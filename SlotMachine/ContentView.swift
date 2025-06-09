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
	@State private var highscore: Int = UserDefaults.standard.integer(forKey: "highscore")
	@State private var betAmount: Int = 10
	@State private var isActiveBet10: Bool = true
	@State private var isActiveBet20: Bool = false
	@State private var showingModal: Bool = false
	
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
		UserDefaults.standard.set(highscore, forKey: "highscore")
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
	
	private func isGameOver() {
		if coins <= 0 {
			showingModal = true
		}
	}
	
	private func resetGame() {
		UserDefaults.standard.set(0, forKey: "highscore")
		highscore = 0
		coins = 100
		activateBet10()
	}
	
	
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
						isGameOver()
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
					resetGame()
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
			.blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
			
			
			// MARK: - popup
			
			if $showingModal.wrappedValue {
				ZStack {
					Color("ColorTransparentBlack")
						.edgesIgnoringSafeArea(.all)
					
					// modal
					
					VStack(spacing: 0) {
						
						// title
						
						Text("GAME OVER")
							.font(.system(.title, design: .rounded))
							.fontWeight(.heavy)
							.padding()
							.frame(minWidth: 0, maxWidth: .infinity)
							.background(Color("ColorPink"))
							.foregroundColor(.white)
						
						Spacer()
						
						// message
						
						VStack(alignment: .center, spacing: 16) {
							Image("gfx-seven-reel")
								.resizable()
								.scaledToFit()
								.frame(maxHeight: 72)
							
							Text("Bad luck! You lost all of the coins.\nLet's play again!")
								.font(.system(.body, design: .rounded))
								.lineLimit(2)
								.multilineTextAlignment(.center)
								.foregroundColor(.gray)
								.layoutPriority(1)
							
							Button(action: {
								showingModal = false
								coins = 100
							}) {
								Text("New Game".uppercased())
									.font(.system(.body, design: .rounded))
									.fontWeight(.semibold)
									.accentColor(Color("ColorPink"))
									.padding(.horizontal, 12)
									.padding(.vertical, 8)
									.frame(minWidth: 128)
									.background(
										Capsule()
											.strokeBorder(lineWidth: 1.75)
											.foregroundColor(Color("ColorPink"))
									)
							} // Button
						} // VStack
						
						Spacer()
						
					} // VStack
					.frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
					.background(.white)
					.cornerRadius(20)
					.shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
					
				} // ZStack
			} // if
			
			
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
