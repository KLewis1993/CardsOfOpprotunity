//
//  GameViewModel.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

import SwiftUI

@MainActor
class GameViewModel: ObservableObject {
    @Published var cardOneImage: Image? = nil
    @Published var cardTwoImage: Image? = nil
    @Published var selectedCardIndex1: Int? = nil
    @Published var selectedCardIndex2: Int? = nil
    @Published var playOneScore: Int = 0
    @Published var playTwoScore: Int = 0
    @Published var isShowingHand: Bool = false
    @Published var alertMessage: String = ""
    @Published var gameOver: Bool = false
    @Published var showAlert: Bool = false
    
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
        gameOver = false
        isShowingHand = false
        cardOneImage = nil
        cardTwoImage = nil
        selectedCardIndex1 = nil
        selectedCardIndex2 = nil
    }
    
    func fetchCards() async -> [Card] {
        guard !isShowingHand else {
            resetBoard()
            return []
        }
        do {
            return try await CardGameNetworkManager.fetchCards()
        } catch {
            DispatchQueue.main.async {
                self.processError(error)
            }
        }
        return []
    }
    
    
    
    private func determineOutcome(_ playerOne: Int, _ playerTwo: Int) {
        guard playerOne == 3 || playerTwo == 3 else {
            return
        }
        
        self.gameOver = true
        
        if playOneScore > playerTwo {
            print("Player 1 Won with: \(playOneScore)")
        } else {
            print("Player 2 Won with: \(playTwoScore)")
        }
    }
    
    private func adjustScore(_ playerOne: Int, _ playerTwo: Int) {
        if playerOne > playerTwo {
            playOneScore += 1
        } else {
            playTwoScore += 1
        }
        
        determineOutcome(playOneScore, playTwoScore)
    }
    
    func revealCards() async throws {
        
        let cards = await fetchCards()
        
        guard !cards.isEmpty, cards.count == 2 else {
            throw NetworkingError.invalidData
        }
        
        do {
            self.cardOneImage = try await CardGameNetworkManager.fetchImage(for: cards[0])
            self.cardTwoImage = try await CardGameNetworkManager.fetchImage(for: cards[1])
            self.isShowingHand = true
            
            if cards[0].rank != cards[1].rank {
                adjustScore(cards[0].rank, cards[1].rank)
            }
            
        } catch {
            throw NetworkingError.invalidData
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
