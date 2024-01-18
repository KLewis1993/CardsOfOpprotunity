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
        case .invalidServerResponse:
            return "Invalid server response."
        case .decodingError:
            return "Failed to decode data."
        default:
            return "An error occurred. Please try again."
        }
    }
}
