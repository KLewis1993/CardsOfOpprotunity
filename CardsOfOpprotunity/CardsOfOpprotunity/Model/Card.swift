//
//  Card.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

struct CardsDictionary: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let suit: String
    let image: String
    let value: String
    
    /// The numerical rank of the card.
    var rank: Int {
        if let integerValue = Int(value) {
            return integerValue
        }
        switch value {
        case "ACE":
            return 1
        case "JACK":
            return 11
        case "QUEEN":
            return 12
        case "KING":
            return 13
        default:
            return 0
        }
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
}



