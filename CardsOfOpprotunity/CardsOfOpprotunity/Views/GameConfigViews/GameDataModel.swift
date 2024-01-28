//
//  GameDataModel.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/20/24.
//

import Foundation

class GameData: ObservableObject {
    @Published var playerOneName: String = "adfasdf"
    @Published var playerTwoName: String = "334343 "
    @Published var enteredBet: String = "Loser has to take out the trash"
    
    var isGameSetupReady: Bool {
        !playerOneName.isEmpty && !playerTwoName.isEmpty && !enteredBet.isEmpty
    }
}
