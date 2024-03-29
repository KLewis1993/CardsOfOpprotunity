//
//  RulesView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/25/24.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Text("Rules")
                    .font(.title2)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                DismissButton()
            }
            .padding()
            
            Text("Quick Break Down")
                .font(.title.bold())
            
            Text("Highest card value earns a point\nFirst player to reach 3 points wins the game")
                .font(.body)
                .multilineTextAlignment(.center)
              
            
            Divider()
            
            Text("Understanding Card Values")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("2-10: Face value")
                Text("Ace = 1")
                Text("Jack = 11")
                Text("Queen = 12")
                Text("King = 13")
            }
            .font(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)
            Spacer()
            
            Image("rulesImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityLabel(Text("Illustration of card values"))
                .accessibilityAddTraits(.isImage)
        }
        .padding()
    }
}

#Preview {
    RulesView()
}
