//
//  CoindDetailsViewModel.swift
//  swiftCoin
//
//  Created by User on 4.1.2024.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinService
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    @Published var errorMessage: String?
    
    init(coinId: String, service: CoinService) {
        self.service = service
        self.coinId = coinId
    }

    @MainActor
    func fetchConDetails() {
        Task {
            do {
                self.coinDetails = try await self.service.fetchDetails(id: self.coinId)
            } catch {
                if let error = error as? CoinAPIError {
                    self.errorMessage = error.customDescription
                }
            }
        }
    }
}
