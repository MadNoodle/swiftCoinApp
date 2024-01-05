//
//  ImageCachedView.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import SwiftUI

struct ImageCachedView: View {
    @StateObject var imageLoader: ImageDownloader
    
    init(url: String) {
        self._imageLoader = StateObject(wrappedValue: ImageDownloader(url: url))
    }
    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}

#Preview {
    ImageCachedView(url: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
