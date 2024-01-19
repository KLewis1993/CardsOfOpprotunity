//
//  ContentView.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/15/24.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            BoardGameView()
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Cards Of Opprotunity!!!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

struct OddsView: View {
    @StateObject var gameData = GameData()
    @State private var showingRules = false

    var body: some View {
        NavigationView {
            VStack {
                Text("What are the Odds?")
                    .font(.largeTitle)
                    .padding()

                VStack(alignment: .leading, spacing: 20) {
                    Text("Name Of Players")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Player 1 Name", text: $gameData.playerOneName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    TextField("Player 2 Name", text: $gameData.playerTwoName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Whats on the line?")
                            .padding(.leading)
                        Spacer()
                        Button("Rules") {
                            showingRules = true
                        }
                        .padding()
                        .sheet(isPresented: $showingRules, content: {
                            RulesView()
                                .border(Color.black)
                        })
                    }
                    
                    TextField("Ex: Take out the trash", text: $gameData.enteredBet)
                        .frame(minHeight: 80)
                        .padding(.horizontal, 4)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                    
                }
                .padding()

                Spacer()
                NavigationLink(destination: BoardGameView()) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .hidden(!gameData.isBothNamesEntered)
                .disabled(!gameData.isBothNamesEntered)
                .padding(.bottom)
            }
        }
    }
}

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Text("Rules")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            
            Text("Quick Break Down")
                .font(.title)
                .padding()
            
            Text("Highest card value earns a point\nFirst player to reach 2 points wins the game")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // Your image here
            Image("rulesIllustration") // Replace with your image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true) // Hides the default back button
        .navigationBarHidden(true) // Hides the navigation bar if you want a custom look
    }
}


struct OddsView_Previews: PreviewProvider {
    static var previews: some View {
        OddsView()
    }
}

#Preview {
    OddsView()
}
