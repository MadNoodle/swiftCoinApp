//
//  ContentView.swift
//  swiftCoin
//
//  Created by User on 2.1.2024.
//

import SwiftUI

struct ContentView: View {
    private let service: CoinService
    @StateObject private var viewModel: CoinsViewModel
    
    init(environment: Environment) {
        self.service = environment.service
        self._viewModel =  StateObject(wrappedValue: CoinsViewModel(service: environment.service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundColor(.gray)
                            ImageCachedView(url: coin.image)
                                .frame(width: 32, height: 32)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.semibold)
                                Text(coin.symbol.uppercased())
                                
                            }
                        }
                        .onAppear {
                            if coin == self.viewModel.coins.last {
                                Task { await self.viewModel.fetchCoins()}
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            .navigationTitle("Coins")
            .navigationDestination(for: Coin.self, destination: { coin in CoinDetailsView(coin: coin, service: service)})
            .overlay {
                if let error = self.viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .task {
            await self.viewModel.fetchCoins()
        }
    }
}

#Preview {
    ContentView(environment: .mock)
}
