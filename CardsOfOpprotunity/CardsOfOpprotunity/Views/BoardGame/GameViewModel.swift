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
    @Published var firstSelectedCardIndex: Int? = nil
    @Published var secondSelectedCardIndex: Int? = nil
    @Published var playerOneScore: Int = 0
    @Published var playerTwoScore: Int = 0
    @Published var isShowingHand: Bool = false
    @Published var alertMessage: String = ""
    @Published var gameOver: Bool = false
    @Published var showAlert: Bool = false
    @Published var playerOneRank: Int = 0
    @Published var playerTwoRank: Int = 0
    
    private var networkManager: CardGameNetworkManagerProtocol
    
    init(networkManager: CardGameNetworkManagerProtocol = CardGameNetworkManager()) {
        self.networkManager = networkManager
    }
    
    var userSelectedCards: Bool {
        firstSelectedCardIndex == nil || secondSelectedCardIndex == nil
    }
    
    var buttonTitle: String {
        if gameOver {
            return "Play Again?"
        } else if isShowingHand {
            return "Draw Again"
        } else if userSelectedCards {
            return "Select Cards"
        } else {
            return "Draw"
        }
    }
    
    func resetBoard() {
        gameOver = false
        isShowingHand = false
        cardOneImage = nil
        cardTwoImage = nil
        firstSelectedCardIndex = nil
        secondSelectedCardIndex = nil
        playerOneRank = 0
        playerTwoRank = 0
    }
    
    func fetchCards() async -> [Card] {
        guard !isShowingHand else {
            resetBoard()
            return []
        }
        do {
            return try await networkManager.fetchCards()
        } catch {
            DispatchQueue.main.async {
                self.processError(error)
            }
        }
        return []
    }
    
    func determineOutcome(_ playerOne: Int, _ playerTwo: Int) {
        //Ensure one of the players has reached the score of '3'
        guard playerOne == 3 || playerTwo == 3 else {
            return
        }
        
        self.gameOver = true
        
        if playerOneScore > playerTwo {
            //TODO: Add a UI element to display who won
            print( "Player 1 Won with: \(playerOneRank)")
        } else {
            //TODO: Add a UI element to display who won
            print( "Player 2 Won with: \(playerTwoRank)")
        }
    }
    
    func adjustScore(_ cardOneRank: Int, _ cardTwoRank: Int) {
        //Prevent incrementing the score if the users' card values are the same
        guard cardOneRank != cardTwoRank else {
            return
        }
        
        if cardOneRank > cardTwoRank {
            playerOneScore += 1
        } else {
            playerTwoScore += 1
        }
        
        determineOutcome(playerOneScore, playerTwoScore)
        playerOneRank = cardOneRank
        playerTwoRank = cardTwoRank
    }
    
    func revealCards() async throws {
        let cards = await fetchCards()
        
        guard !cards.isEmpty, cards.count == 2 else {
            throw NetworkingError.invalidData
        }
        
        do {
            self.cardOneImage = try await networkManager.fetchImage(for: cards[0])
            self.cardTwoImage = try await networkManager.fetchImage(for: cards[1])
            self.isShowingHand = true
            
            adjustScore(cards[0].rank, cards[1].rank)
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
