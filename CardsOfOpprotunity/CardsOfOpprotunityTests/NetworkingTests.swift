//
//  NetworkingTests.swift
//  CardsOfOpportunityTests
//
//  Created by Ivan Ramirez on 1/19/24.
//

import XCTest
@testable import CardsOfOpprotunity

final class NetworkingTests: XCTestCase {
    
    func testFetchCardsSuccess() async throws {
        let mockNetworkManager = MockNetworkManager()
        
        mockNetworkManager.cardsToReturn = [
            Card(suit: "Hearts", image: "", value: "JACK"),
            Card(suit: "Hearts", image: "", value: "8")
        ]
        
        let viewModel = await GameViewModel(networkManager: mockNetworkManager)
        
        let fetchedCards = await viewModel.fetchCards()
        
        XCTAssertEqual(fetchedCards.count, 2)
        XCTAssertEqual(fetchedCards.first?.rank.description, "11")
        XCTAssertGreaterThan(fetchedCards[0].rank, fetchedCards[1].rank, "The value of the Jack card is higher then that of am `8` value")
    }
    
    @MainActor
    func testFetchCardsFailure() async {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkingError.invalidData
        
        let viewModel = GameViewModel(networkManager: mockNetworkManager)
        
        _ = await viewModel.fetchCards()
        try? await Task.sleep(nanoseconds: 1000_0000_000)
        
        XCTAssertEqual(viewModel.alertMessage, NetworkingError.invalidData.userFriendlyMessage, "The alert message should be set when there is a networking error")
        XCTAssertTrue(viewModel.showAlert, "Alert should be shown when there is a networking error")
    }
}
