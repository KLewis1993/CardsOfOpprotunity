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
           //Spacer()
            Text("Take out the trash\(gameData.enteredBet)")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                //Spacer()
            VStack(spacing: 0) {
                CardSelectionView(selectedCardIndex: $viewModel.firstSelectedCardIndex, isOffsetPositive: true)
                    .scaledToFit()
                
                HStack{
                    Text("Player 1:\(gameData.playerOneName)")
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
                        showingResults = true
                    } catch {
                        
                    }
                }
                .disabled(viewModel.userSelectedCards)
                .opacity(viewModel.userSelectedCards ? 0.8 : 1)
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
                    //.frame(maxHeight: .infinity)
                    .scaledToFit()
            }
            Spacer()
            .sheet(isPresented: $showingResults) {
                ResultsView(viewModel: viewModel)
            }
            
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

    struct ResultsView: View {
        @Environment(\.presentationMode) var presentationMode
        @ObservedObject var viewModel = GameViewModel()
        
        var body: some View {
            VStack(spacing: 20)  {
                Button(action: {
                    // Action to go back
                    presentationMode.wrappedValue.dismiss()
                    viewModel.resetBoard()
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                (viewModel.cardOneImage ?? Image("cardBack"))
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                if viewModel.playerOneRank > viewModel.playerTwoRank
                {
                    Text("Player one wins with \(viewModel.playerOneRank)")
                        .font(.title.bold())
                } else {
                    Text("Player Two wins with \(viewModel.playerTwoRank)")
                        .font(.title.bold())
                }
                Spacer()
                (viewModel.cardTwoImage ?? Image("cardBack"))
                    .resizable()
                    .scaledToFit()
            }
            .onAppear {
                viewModel.isShowingHand = true
            }
            //.hidden(!viewModel.isShowingHand)
        }
    }

#Preview {
    BoardGameView(gameData: GameData())
}

#Preview("ResultView") {
    ResultsView(viewModel: GameViewModel())
}
    
//    var body: some View {
//        ZStack {
//            VStack(spacing: 130) {
//                CardSelectionView(selectedCardIndex: $viewModel.firstSelectedCardIndex, isOffsetPositive: true)
//                CardSelectionView(selectedCardIndex: $viewModel.secondSelectedCardIndex, isOffsetPositive: false)
//            }
//            .hidden(viewModel.isShowingHand)
//            
//            VStack(spacing: 50)  {
//                (viewModel.cardOneImage ?? Image("cardBack"))
//                    .resizable()
//                    .scaledToFit()
//                Spacer()
//                (viewModel.cardTwoImage ?? Image("cardBack"))
//                    .resizable()
//                    .scaledToFit()
//            }
//            .hidden(!viewModel.isShowingHand)
//            
//            VStack {
//                Spacer()
//                LoadingButton(title: viewModel.buttonTitle) {
//                    do {
//                        try await viewModel.revealCards()
//                    } catch {
//                        
//                    }
//                }
//                .disabled(viewModel.userSelectedCards)
//                .opacity(viewModel.userSelectedCards ? 0.6 : 1)
//                .animation(.easeInOut, value: viewModel.userSelectedCards)
//                Spacer()
//            }
//        }
//        .alert(isPresented: $viewModel.showAlert) {
//            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
//        }
//    }
//}
//
//
//#Preview {
//    BoardGameView()
//}





