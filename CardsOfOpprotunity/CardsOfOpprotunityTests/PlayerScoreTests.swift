//
//  PlayerScoreTests.swift
//  CardsOfOpportunityTests
//
//  Created by Ivan Ramirez on 1/18/24.
//

import XCTest
@testable import CardsOfOpprotunity

final class PlayerScoreTests: XCTestCase {
    
    @MainActor func testSuccessfulScoreIncrement() {
        let gameViewModel = GameViewModel()
        gameViewModel.adjustScore(4, 3)
        
        XCTAssertGreaterThan(gameViewModel.playerOneScore, gameViewModel.playerTwoScore, "Player one's score has gone up")
    }
    
    @MainActor func testNoScoreIncrementForEqualScores() {
        let gameViewModel = GameViewModel()
        gameViewModel.adjustScore(2, 2)
        
        XCTAssertEqual(gameViewModel.playerOneScore, 0, "Player one's score should remain the same")
        XCTAssertEqual(gameViewModel.playerTwoScore, 0, "Player two's score should remain the same")
    }
    
}
