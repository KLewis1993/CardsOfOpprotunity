//
//  CardSelectionView.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/17/24.
//

import SwiftUI

struct CardSelectionView: View {
    @Binding var selectedCardIndex: Int?
    var isOffsetPositive: Bool
    
    private var offsetValue: CGFloat {
        isOffsetPositive ? 20 : -20
    }
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Image("cardBack")
                    .resizable()
                    .scaledToFit()
                    .offset(y: selectedCardIndex == index ? offsetValue : 0)
                    .onTapGesture {
                        if selectedCardIndex == index {
                            selectedCardIndex = nil
                        } else {
                            selectedCardIndex = index
                        }
                    }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: selectedCardIndex)
    }
}


#Preview {
    @State var selectedCardIndex: Int? = nil
    
   return CardSelectionView(selectedCardIndex: $selectedCardIndex, isOffsetPositive: false)
}
