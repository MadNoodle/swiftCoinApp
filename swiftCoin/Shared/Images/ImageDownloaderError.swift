//
//  ImageDownloaderError.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import Foundation

enum ImageDownloaderError: Error {
    case invalidURL
    case invalidData
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL construction"
        case .invalidData:
            return "Invalid data to create UIImage"
        case .unknownError(error: let error):
            return "An error occured while fetching image: \(error.localizedDescription)"
        }
    }
}
