//
//  CoinAPIError.swift
//  
//
//  Created by User on 4.1.2024.
//

import Foundation

enum CoinAPIError: Error {
    case invalidUrl
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case let .requestFailed(description):
            return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode):
            return "Request failed with status code : \(statusCode)"
        case let .unknownError(error):
            return "An unknown error occured: \(error)"
        }
    }
}
