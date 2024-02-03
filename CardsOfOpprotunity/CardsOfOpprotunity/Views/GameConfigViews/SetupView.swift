//
//  SetupView.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/20/24.
//

import SwiftUI

struct SetupView: View {
    @StateObject var gameData = GameData()
    @State private var showRules: Bool = false
    
    init(showRules: Bool = false) {
        self._showRules = State(initialValue: showRules)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Lets play\nthe game")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                    
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
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showRules = true
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("Rules")
                            }
                        })
                        .accessibilityAddTraits(.isButton)
                    }
                }
                .padding()
                .sheet(isPresented: $showRules){
                    RulesView()
                }
                
                Spacer()
                NavigationLink(destination:BoardGameView(gameData: gameData)) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .padding()
                        .background(Color.blue)
                }
                .clipShape(Capsule())
                .opacity(gameData.isGameSetupReady ? 1 : 0.6)
                .disabled(!gameData.isGameSetupReady)
                .padding(.bottom)
                .accessibilityAddTraits(.isButton)
                
                Text("Providing missing information\nin order to continue")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                    .hidden(gameData.isGameSetupReady)
            }
        }
    }
}


#Preview("Typical") {
    SetupView()
}

#Preview("Showing Rules") {
    SetupView(showRules: true)
}
