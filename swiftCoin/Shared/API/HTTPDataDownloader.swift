//
//  HTTPDataDownloader.swift
//  swiftCoin
//
//  Created by User on 4.1.2024.
//

import Foundation

protocol HTTPDataDownloader {
    func makeRequest<T: Decodable>(endpoint: Endpoint, as type: T.Type) async throws -> T
}

extension HTTPDataDownloader {
    func makeRequest<T: Decodable>(endpoint: Endpoint, as type: T.Type) async throws -> T {
        guard
            let urlString = endpoint.url,
                let url = URL(string: urlString)
        else {
            throw CoinAPIError.invalidUrl
        }
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Request failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}
