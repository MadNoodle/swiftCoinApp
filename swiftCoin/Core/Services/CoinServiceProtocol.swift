//
//  CoinService.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import Foundation

protocol CoinService {
    func fetchCoins() async throws -> [Coin]
    func fetchDetails(id: String) async throws -> CoinDetails?
}
