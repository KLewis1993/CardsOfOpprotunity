//
//  GameDataModel.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/20/24.
//

import Foundation

class GameData: ObservableObject {
    @Published var playerOneName: String = ""
    @Published var playerTwoName: String = ""
    @Published var enteredBet: String = ""
    
    var isGameSetupReady: Bool {
        !playerOneName.isEmpty && !playerTwoName.isEmpty && !enteredBet.isEmpty
    }
}
