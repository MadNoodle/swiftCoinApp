//
//  MockCoinService.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import Foundation

class MockCoinService: CoinService {
    
    var mockData: Data?
    var mockError: CoinAPIError?
    
    func fetchCoins() async throws -> [Coin] {
        if let mockError {
            throw mockError
        }
        
        do {
            return try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoinsData)
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
        
    }
    
    func fetchDetails(id: String) async throws -> CoinDetails? {
        return .init(
            id: "BTC",
            symbol: "BTC",
            name: "Bitcoin",
            description: .init(text: "This is a description")
        )
    }
}
