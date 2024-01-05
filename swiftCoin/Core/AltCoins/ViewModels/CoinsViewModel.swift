//
//  CoinsViewModel.swift
//  swiftCoin
//
//  Created by User on 3.1.2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let service: CoinService
    
    init(service: CoinService) {
        self.service = service
    }
    
    @MainActor
    func fetchCoins() async {
        do {
            let additionnalCoins = try await self.service.fetchCoins()
            self.coins.append(contentsOf: additionnalCoins)
        } catch {
            guard let error = error as? CoinAPIError else { return }
            self.errorMessage = error.customDescription
        }
    }
    
}
