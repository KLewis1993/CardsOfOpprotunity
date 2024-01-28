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
    @Environment(\.presentationMode) var presentationMode
    @State private var showingResults = false
    
    var body: some View {
        ZStack {
            VStack() {
                VStack(spacing: 0) {
                    CardDisplayView(
                        selectedCardIndex: $viewModel.firstCardIndex,
                        cardImage: viewModel.cardOneImage,
                        isOffsetPositive: true
                    )
                    
                    PlayerDetails(playerName: gameData.playerOneName, playerScore: viewModel.playerOneScore)
                    
                    LoadingButton(title: viewModel.buttonTitle) {
                        await viewModel.revealCards()
                    }
                    .disabled(viewModel.userSelectedCards)
                    .opacity(viewModel.userSelectedCards ? 0.6 : 1)
                    .animation(.easeInOut, value: viewModel.userSelectedCards)
                    .padding()
                    
                    PlayerDetails(playerName: gameData.playerTwoName, playerScore: viewModel.playerTwoScore)
                    
                    CardDisplayView(
                        selectedCardIndex: $viewModel.secondCardIndex,
                        cardImage: viewModel.cardTwoImage,
                        isOffsetPositive: false)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $viewModel.gameOver) {
                GameOverView(
                    playerOneName: gameData.playerOneName,
                    playerTwoName: gameData.playerTwoName,
                    playerOneScore: viewModel.playerOneScore,
                    playerTwoScore: viewModel.playerTwoScore,
                    bet: gameData.enteredBet
                )
                
            }
            .presentationDetents([.medium])
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





