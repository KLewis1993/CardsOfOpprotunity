//
//  OddsView.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/20/24.
//

import SwiftUI

struct OddsView: View {
    @StateObject var gameData = GameData()
    @State private var showingRules = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Lets play\nthe game")
                        .font(.largeTitle.bold())
                    
                    TextField("Player 1 Name", text: $gameData.playerOneName)
                        .modifier(CustomTextFieldStyle())
                    
                    TextField("Player 2 Name", text: $gameData.playerTwoName)
                        .modifier(CustomTextFieldStyle())
                        .padding(.bottom)
                    
                    Text("What's on the line?")
                        .font(.title.bold())
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $gameData.enteredBet)
                            .padding(4)
                            .opacity(gameData.enteredBet.isEmpty ? 0.25 : 1)
                            .animation(.default, value: gameData.enteredBet.isEmpty)
                        
                        if gameData.enteredBet.isEmpty {
                            Text("Example: Take out the trash")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .allowsHitTesting(false)
                        }
                    }
                    .frame(maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showingRules = true
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("Rules")
                            }
                        })
                    }
                }
                .padding()
                .sheet(isPresented: $showingRules){
                    RulesView()
                }
                .presentationDetents([.medium])
                
                Spacer()
                NavigationLink(destination: BoardGameView()) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .padding()
                        .background(Color.blue)
                }
                .clipShape(Capsule())
                .hidden(!gameData.isGameSetupReady)
                .disabled(!gameData.isGameSetupReady)
                .padding(.bottom)
            }
        }
    }
}

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Text("Rules")
                    .font(.title2)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.primary)
                })
            }
            .padding()
            
            Text("Quick Break Down")
                .font(.title.bold())
            
            Text("Highest card value earns a point\nFirst player to reach 3 points wins the game")
                .font(.body)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Image("rulesImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
    }
}

#Preview {
    OddsView()
}
