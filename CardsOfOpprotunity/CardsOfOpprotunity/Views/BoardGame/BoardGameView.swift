//
//  BoardGameView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

import SwiftUI

struct BoardGameView: View {
    @ObservedObject var viewModel = GameViewModel()
    @ObservedObject var gameData: GameData
    
    var body: some View {
        ZStack {
            VStack() {
                VStack(spacing: 0) {
                    CardDisplayView(
                        selectedCardIndex: $viewModel.firstCardIndex,
                        cardImage: viewModel.cardOneImage,
                        isOffsetPositive: true
                    )
                    .accessibilityLabel(viewModel.isShowingHand ? "Cards face down" : "Card face view")
                    
                    PlayerDetails(playerName: gameData.playerOneName, playerScore: viewModel.playerOneScore)
                        .accessibilityLabel("Player one section")
                    
                    LoadingButton(title: viewModel.buttonTitle) {
                        await viewModel.revealCards()
                    }
                    .disabled(viewModel.userSelectedCards)
                    .opacity(viewModel.userSelectedCards ? 0.6 : 1)
                    .animation(.easeInOut, value: viewModel.userSelectedCards)
                    .padding()
                    .accessibilityLabel("Draw button")
                    .accessibilityAction(named: Text("Reveal Cards")) {
                        if !viewModel.userSelectedCards {
                            Task {
                                await viewModel.revealCards()
                            }
                        }
                    }
                    .accessibilityHint("Tap to reveal cards if both players have selected a card. This action is only available when the draw button is enabled.")
                    
                    
                    PlayerDetails(playerName: gameData.playerTwoName, playerScore: viewModel.playerTwoScore)
                        .accessibilityLabel("Player two section")
                    
                    CardDisplayView(
                        selectedCardIndex: $viewModel.secondCardIndex,
                        cardImage: viewModel.cardTwoImage,
                        isOffsetPositive: false)
                    .accessibilityLabel(viewModel.isShowingHand ? "Cards face down" : "Card face view")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $viewModel.showGameOverAlert) {
                GameOverView(
                    playerOneName: gameData.playerOneName,
                    playerTwoName: gameData.playerTwoName,
                    playerOneScore: viewModel.playerOneScore,
                    playerTwoScore: viewModel.playerTwoScore,
                    bet: gameData.enteredBet
                )
            }
        }
    }
}

private struct CardDisplayView: View {
    @Binding var selectedCardIndex: Int?
    var cardImage: Image?
    var isOffsetPositive: Bool
    
    var body: some View {
        if cardImage == nil {
            CardSelectionView(selectedCardIndex: $selectedCardIndex, isOffsetPositive: isOffsetPositive)
                .scaledToFit()
        } else {
            (cardImage ?? Image("cardBack"))
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
    }
}

#Preview {
    BoardGameView(gameData: GameData())
}





