//
//  LoadingButton.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/17/24.
//

import SwiftUI

struct LoadingButton: View {
    let title: String
    let action: () async -> Void
    
    @State private var isLoading = false
    @State private var showProgressView = false
    
    var body: some View {
        Button(action: {
            executeAction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if isLoading {
                    showProgressView = true
                }
            }
        }) {
            ZStack {
                if showProgressView {
                    ProgressView()
                } else {
                    Text(title)
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 250)
            .padding()
            .foregroundColor(showProgressView ? .clear : .white)
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .buttonStyle(LoadingButtonStyle())
        .disabled(isLoading)
    }
    
    private func executeAction() {
        Task {
            isLoading = true
            await action()
            isLoading = false
            showProgressView = false
        }
    }
}

struct LoadingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .clipShape(Capsule())
    }
}

#Preview {
    LoadingButton(title: "Draw") {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
