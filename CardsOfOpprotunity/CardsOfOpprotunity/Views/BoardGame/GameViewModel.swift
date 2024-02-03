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
    @Published var firstCardIndex: Int? = nil
    @Published var secondCardIndex: Int? = nil
    @Published var playerOneScore: Int = 0
    @Published var playerTwoScore: Int = 0
    @Published var isShowingHand: Bool = false
    @Published var alertMessage: String = ""
    @Published var gameOver: Bool = false
    @Published var showGameOverAlert: Bool = false
    @Published var showAlert: Bool = false
    
    private var networkManager: CardGameNetworkManagerProtocol
    
    init(networkManager: CardGameNetworkManagerProtocol = CardGameNetworkManager()) {
        self.networkManager = networkManager
    }
    
    var userSelectedCards: Bool {
        firstCardIndex == nil || secondCardIndex == nil
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
        if gameOver {
            playerOneScore = 0
            playerTwoScore = 0
        }
        gameOver = false
        isShowingHand = false
        cardOneImage = nil
        cardTwoImage = nil
        firstCardIndex = nil
        secondCardIndex = nil
    }
    
    func fetchCards() async -> [Card] {
        do {
            return try await networkManager.fetchCards()
        } catch {
            self.processError(error)
            return []
        }
    }
    
    func determineOutcome() {
        //Ensure one of the players has reached the score of '3'
        guard playerOneScore == 3 || playerTwoScore == 3 else {
            return
        }
        
        self.gameOver = true
        self.showGameOverAlert = true
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
        
        determineOutcome()
    }
    
    func revealCards() async {
        if isShowingHand {
            resetBoard()
            return
        }
        
        let cards = await fetchCards()
        
        guard cards.count == 2 else {
            return
        }
        
        do {
            async let cardOneImage = try networkManager.fetchImage(for: cards[0])
            async let cardTwoImage = try networkManager.fetchImage(for: cards[1])
            
            let (imageOne, imageTwo) = await (try cardOneImage, try cardTwoImage)
            
            DispatchQueue.main.async {
                self.cardOneImage = imageOne
                self.cardTwoImage = imageTwo
                self.isShowingHand = true
                self.adjustScore(cards[0].rank, cards[1].rank)
            }
        } catch {
            processError(error)
        }
    }
    
    private func processError(_ error: Error) {
        alertMessage = (error as? NetworkingError)?.userFriendlyMessage ?? error.localizedDescription
        showAlert = true
    }
}
