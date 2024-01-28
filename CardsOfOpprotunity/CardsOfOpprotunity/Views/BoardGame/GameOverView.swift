//
//  GameOverView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/27/24.
//

import SwiftUI

struct GameOverView: View {
    @Environment(\.presentationMode) var presentationMode
    var playerOneName: String
    var playerTwoName: String
    var playerOneScore: Int
    var playerTwoScore: Int
    var bet: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
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
            
            Text("Game Over")
                .font(.largeTitle.bold())
                .padding()
            
            let winnerName = playerOneScore > playerTwoScore ? playerOneName : playerTwoName
            let loserName = playerOneScore > playerTwoScore ? playerTwoName : playerOneName
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(winnerName) won!")
                    .font(.title.bold())
                    .multilineTextAlignment(.leading)
                
                Text("Bet for \(loserName): \(bet)")
                    .font(.headline.bold())
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    GameOverView(playerOneName: "Arnold", playerTwoName: "Helga", playerOneScore: 2, playerTwoScore: 3, bet: "Take out the trash")
}
