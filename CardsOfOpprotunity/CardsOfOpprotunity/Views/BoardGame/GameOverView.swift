//
//  GameOverView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/27/24.
//

import SwiftUI

struct GameOverView: View {
    
    var playerOneName: String
    var playerTwoName: String
    var playerOneScore: Int
    var playerTwoScore: Int
    var bet: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Spacer()
                
                DismissButton()
            }
            
            Text("Game Over")
                .font(.largeTitle.bold())
                .padding()
                .accessibilityAddTraits(.isHeader)
            
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
            .accessibilityElement(children: .combine)
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    GameOverView(
        playerOneName: "Arnold",
        playerTwoName: "Helga",
        playerOneScore: 2, playerTwoScore: 3,
        bet: "Take out the trash"
    )
}
