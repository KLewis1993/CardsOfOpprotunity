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
                HStack() {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("Current Bet:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.trailing, 70)
                    
                    Spacer()
                }
               
                Text("\(gameData.enteredBet)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 0) {
                    CardSelectionView(selectedCardIndex: $viewModel.firstSelectedCardIndex, isOffsetPositive: true)
                        .scaledToFit()
                    
                    HStack{
                        Text("Player 1: \(gameData.playerOneName)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 0)
                            .font(.title2.bold())
                            .padding()
                        Text("Score: \(viewModel.playerOneScore)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    LoadingButton(title: viewModel.buttonTitle) {
                        do {
                            try await viewModel.revealCards()
                            viewModel.isShowingHand = true
                        } catch {
                            
                        }
                    }
                    .disabled(viewModel.userSelectedCards)
                    .opacity(viewModel.userSelectedCards ? 0.6 : 1)
                    .animation(.easeInOut, value: viewModel.userSelectedCards)
                    .padding()
                    
                    HStack {
                        Text("Player 2: \(gameData.playerTwoName)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .font(.title2.bold())
                        Text("Score: \(viewModel.playerTwoScore)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    CardSelectionView(selectedCardIndex: $viewModel.secondSelectedCardIndex, isOffsetPositive: false)
                        .scaledToFit()
                }
                Spacer()
                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
            if viewModel.isShowingHand {
                ResultsView(viewModel: viewModel)
                    .frame(width: 350, height: 700)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius:20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 5)
                    )
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: viewModel.isShowingHand) 
    }
}

struct ResultsView: View {
    @ObservedObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            (viewModel.cardOneImage ?? Image("cardBack"))
                .resizable()
                .scaledToFit()
                .padding(.horizontal)

            Text(viewModel.resultText)
                .font(.title.bold())
                .padding(.vertical)

            (viewModel.cardTwoImage ?? Image("cardBack"))
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                viewModel.startNewRound()
                viewModel.isShowingHand = false
            }) {
                Text("Done")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .cornerRadius(50)
            .background(Color.blue)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            viewModel.isShowingHand = true
        }
    }
}

#Preview {
    BoardGameView(gameData: GameData())
}

#Preview("ResultView") {
    ResultsView(viewModel: GameViewModel())
}





