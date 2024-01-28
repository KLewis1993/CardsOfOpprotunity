//
//  PlayerDetails.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/25/24.
//

import SwiftUI

struct PlayerDetails: View {
    var playerName: String
    var playerScore: Int
    
    var body: some View {
        HStack{
            Text("\(playerName)")
                .font(.subheadline)
            Spacer()
            Text("Score: \(playerScore)")
                .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    PlayerDetails(playerName: "Super Mario", playerScore: 2)
}
