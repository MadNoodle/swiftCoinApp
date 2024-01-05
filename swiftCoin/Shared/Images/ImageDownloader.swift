//
//  ImageDownloader.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import SwiftUI

class ImageDownloader: ObservableObject {
    @Published var image: Image?
    
    private let urlString: String
    private let imageCache = ImageCache.shared
    
    init(url: String) {
        self.urlString = url
        Task { try? await self.loadImage() }
    }
    
    @MainActor
    private func loadImage() async throws {
        if let cached = self.imageCache.get(forKey: self.urlString) {
            self.image = Image(uiImage: cached)
        }
        
        guard let url = URL(string: self.urlString) else {
            throw ImageDownloaderError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let uiImage = UIImage(data: data) else {
                throw ImageDownloaderError.invalidData
            }
            
            self.imageCache.set(uiImage, forKey: self.urlString)
            self.image = Image(uiImage: uiImage)
        } catch {
            throw ImageDownloaderError.unknownError(error: error)
        }
    }
}
