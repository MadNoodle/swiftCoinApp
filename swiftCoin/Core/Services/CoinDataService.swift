//
//  CoinDataService.swift
//  swiftCoin
//
//  Created by User on 3.1.2024.
//

import Foundation

class CoinDataService: HTTPDataDownloader, CoinService {
    
    private enum Constants {
        /// Number of items per page
        static let fetchLimit = 20
    }
    
    // MARK: - Properties
    /// Page number we are querying
    private var currentPage = 0
    
    // MARK: - GET Methods
    /// Fetches the list of cryptos available on coinGecko API
    /// this call can be paginated using `page` and `fetch limit` variable
    /// /// - Returns: `[Coin]` array of coins
    func fetchCoins() async throws -> [Coin] {
        self.currentPage += 1
        return try await self.makeRequest(endpoint: .coins(page: self.currentPage, limit: Constants.fetchLimit), as: [Coin].self)
    }
    
    /// Fetches a dedicated crypto available on coinGecko API
    /// - Parameter id: id of the crypto
    /// - Returns: `CoinDetails` of the requested currency
    func fetchDetails(id: String) async throws -> CoinDetails? {
        if let cached = CoinDetailsCache.shared.get(forKey: id) {
            return cached
        }
        let details = try await self.makeRequest(endpoint: .coinDetails(id: id), as: CoinDetails.self)
        
        CoinDetailsCache.shared.set(details, forKey: id)
        return details
    }
}
