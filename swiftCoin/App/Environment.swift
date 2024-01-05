//
//  Environment.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import Foundation

enum Environment {
    case live
    case mock
    
    var service: CoinService {
        switch self {
        case .live:
            return CoinDataService()
        case .mock:
            return MockCoinService()
        }
    }
}
