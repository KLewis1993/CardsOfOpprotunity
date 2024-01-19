//
//  BoardGameView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

import SwiftUI

struct BoardGameView: View {
    @ObservedObject var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 130) {
                CardSelectionView(selectedCardIndex: $viewModel.firstSelectedCardIndex, isOffsetPositive: true)
                CardSelectionView(selectedCardIndex: $viewModel.secondSelectedCardIndex, isOffsetPositive: false)
            }
            .hidden(viewModel.isShowingHand)
            
            VStack(spacing: 50)  {
                (viewModel.cardOneImage ?? Image("cardBack"))
                    .resizable()
                    .scaledToFit()
                Spacer()
                (viewModel.cardTwoImage ?? Image("cardBack"))
                    .resizable()
                    .scaledToFit()
            }
            .hidden(!viewModel.isShowingHand)
            
            VStack {
                Spacer()
                LoadingButton(title: viewModel.buttonTitle) {
                    do {
                        try await viewModel.revealCards()
                    } catch {
                        
                    }
                }
                .disabled(viewModel.userSelectedCards)
                .opacity(viewModel.userSelectedCards ? 0.8 : 1)
                .animation(.easeInOut, value: viewModel.userSelectedCards)
                Spacer()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    BoardGameView()
}



