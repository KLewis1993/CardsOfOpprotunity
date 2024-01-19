//
//  CardGameNetworkManager.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/17/24.
//

import SwiftUI

struct CardGameNetworkManager {
    static func fetchCards(amount: Int = 2) async throws -> [Card] {
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new") else { 
            throw NetworkingError.badBaseURL
        }
        
        let builtURL = baseURL.appendingPathComponent("draw").appendingPathComponent("/")
        var components = URLComponents(url: builtURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "count", value: "\(amount)")]
        
        guard let queryURL = components?.url else {
            throw NetworkingError.badBuiltURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: queryURL)
        try validate(response)
        
        do {
            let cardArray = try JSONDecoder().decode(CardsDictionary.self, from: data)
            return cardArray.cards
        } catch {
            throw NetworkingError.decodingError
        }
    }
    
    static func fetchImage(for card: Card) async throws -> Image? {
        guard let url = URL(string: card.image) else {
            throw NetworkingError.badBaseURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try validate(response)
        
        if let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            throw NetworkingError.invalidData
        }
    }
    
    ///Checks if the response status code is equal `200`. If the status code is not `200` an error is thrown.
    private static func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
    }
}
