//
//  View+Extensions.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/18/24.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        modifier(ConditionalHiddenModifier(isHidden: shouldHide))
    }
}

struct ConditionalHiddenModifier: ViewModifier {
    var isHidden: Bool
    
    func body(content: Content) -> some View {
        if isHidden {
            content.hidden()
        } else {
            content
        }
    }
}

import SwiftUI

struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.leading, 30)
            .cornerRadius(15)
            .overlay(
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.secondary)
                        .padding(.leading, 15)
                    Spacer()
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
    }
}

extension View {
    func customTextFieldStyle(symbolName: String, isTextEmpty: Bool) -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}


