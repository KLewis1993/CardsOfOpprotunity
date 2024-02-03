//
//  DismissButton.swift
//  CardsOfOpportunity
//
//  Created by Ivan Ramirez on 2/2/24.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.primary)
                .accessibilityLabel(Text("Close view"))
        })
    }
}

#Preview {
    DismissButton()
}
