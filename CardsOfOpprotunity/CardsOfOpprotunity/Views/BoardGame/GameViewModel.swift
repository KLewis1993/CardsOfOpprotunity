//
//  GameViewModel.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

import SwiftUI


class GameViewModel: ObservableObject {
    @Published var gameOver: Bool = false
    @Published var isShowingHand: Bool = false
    @Published var cardOneImage: Image? = nil
    @Published var cardTwoImage: Image? = nil
    @Published var selectedCardIndex1: Int? = nil
    @Published var selectedCardIndex2: Int? = nil
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    // Computed property to check if either card index is nil
    var isAnyCardUnselected: Bool {
        selectedCardIndex1 == nil || selectedCardIndex2 == nil
    }
    
    var buttonTitle: String {
        if gameOver {
            return "Play Again"
        } else if isShowingHand {
            return "Draw Again"
        } else {
            return "Draw"
        }
    }
    
    func resetBoard() {
        isShowingHand = false
        cardOneImage = nil
        cardTwoImage = nil
        selectedCardIndex1 = nil
        selectedCardIndex2 = nil
    }
    
    @MainActor
    func fetchCardImages() async {
        guard !isShowingHand else {
            resetBoard()
            return
        }
        do {
            let cards = try await CardGameNetworkManager.fetchCards()
            
            async let fetchedImageOne = CardGameNetworkManager.fetchImage(for: cards[0])
            async let fetchedImageTwo = CardGameNetworkManager.fetchImage(for: cards[1])
            
            self.cardOneImage = try await fetchedImageOne
            self.cardTwoImage = try await fetchedImageTwo
            self.isShowingHand = true
        } catch {
            DispatchQueue.main.async {
                self.processError(error)
            }
        }
    }
    
    private func processError(_ error: Error) {
        if let networkingError = error as? NetworkingError {
            alertMessage = networkingError.userFriendlyMessage
        } else {
            alertMessage = error.localizedDescription
        }
        showAlert = true
    }
}
