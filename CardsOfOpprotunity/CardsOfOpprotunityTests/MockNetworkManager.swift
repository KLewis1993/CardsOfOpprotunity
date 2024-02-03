//
//  MockNetworkManager.swift
//  CardsOfOpportunityTests
//
//  Created by Ivan Ramirez on 1/19/24.
//

import SwiftUI
@testable import CardsOfOpprotunity

class MockNetworkManager: CardGameNetworkManagerProtocol {
    var cardsToReturn: [Card] = []
    var imageToReturn: Image? = nil
    var errorToThrow: Error? = nil
    
    func fetchCards() async throws -> [Card] {
        if let error = errorToThrow {
            throw error
        }
        return cardsToReturn
    }
    
    func fetchImage(for card: CardsOfOpprotunity.Card) async throws -> Image? {
        if let error = errorToThrow {
            throw error
        }
        return imageToReturn
    }
    
}
