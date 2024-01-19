//
//  NetworkingError.swift
//  CardsOfOpprotunity
//
//  Created by Ivan Ramirez on 1/16/24.
//

import Foundation

enum NetworkingError: Error {
    case badBaseURL
    case invalidData
    case badBuiltURL
    case invalidServerResponse
    case decodingError

    var userFriendlyMessage: String {
        switch self {
        case .badBaseURL:
            return "There's a connection issue. Please check your internet connection and try again."
        case .invalidData:
            return "We encountered a problem processing the data. Please try again later."
        case .badBuiltURL:
            return "There was an error in processing your request. Please try again."
        case .invalidServerResponse:
            return "We received an unexpected response from our server. Please try again shortly."
        case .decodingError:
            return "An error occurred while displaying your cards. Please try again."
        }
    }
}

