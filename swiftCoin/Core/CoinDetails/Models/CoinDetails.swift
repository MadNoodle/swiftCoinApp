//
//  CoinDetails.swift
//  swiftCoin
//
//  Created by User on 4.1.2024.
//

import Foundation

struct CoinDetails: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
