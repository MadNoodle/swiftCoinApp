//
//  CoinDetails.swift
//  swiftCoin
//
//  Created by User on 4.1.2024.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    
    @ObservedObject private var viewModel: CoinDetailsViewModel
    
    init(coin: Coin, service: CoinService) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id, service: service)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                HStack {
                    VStack(alignment: .leading) {
                        Text(details.name)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text(details.symbol.uppercased())
                            .font(.footnote)
                    }
                    Spacer()
                    ImageCachedView(url: coin.image)
                        .frame(width: 64, height: 64)
                }
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical, 10)
            }
        }
        .overlay {
            if let error = self.viewModel.errorMessage {
                Text(error)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            self.viewModel.fetchConDetails()
        }
        .padding(.horizontal)
        .navigationTitle("Details")
        
    }
}

//#Preview {
//    CoinDetailsView
//}
