//
//  GameDataModel.swift
//  CardsOfOpprotunity
//
//  Created by kendrick lewis on 1/19/24.
//

import Foundation

class GameData: ObservableObject {
    @Published var playerOneName: String = ""
    @Published var playerTwoName: String = ""
    @Published var enteredBet: String = ""
    
    var isBothNamesEntered: Bool {
        !playerOneName.isEmpty && !playerTwoName.isEmpty && !enteredBet.isEmpty
    }
}