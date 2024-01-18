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
