//
//  CoindEndpoints.swift
//  swiftCoin
//
//  Created by User on 4.1.2024.
//

import Foundation

enum Endpoint {
    case coins(page: Int, limit: Int)
    case coinDetails(id: String)
    
    var url: String? {
        switch self {
        case .coins, 
             .coinDetails:
                return makeURL()
        }
    }
}

private extension Endpoint {
    
    var baseURLComponents: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.coingecko.com"
        component.path = "/api/v3/coins/"
        return component
    }
    
    func makeURL() -> String? {
        var components = baseURLComponents
        switch self {
        case let .coins(page, limit):
            components.path += "markets"
            
            components.queryItems = [
                .init(name: "vs_currency", value: "usd"),
                .init(name: "order", value: "market_cap_desc"),
                .init(name: "per_page", value: "\(limit)"),
                .init(name: "page", value: "\(page)"),
                .init(name: "price_change_percentage", value: "24h")
            ]
            
        case let .coinDetails(id):
            components.path += id
        }
        return components.string

    }
}
