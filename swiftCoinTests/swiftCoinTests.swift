//
//  swiftCoinTests.swift
//  swiftCoinTests
//
//  Created by User on 2.1.2024.
//

import XCTest
@testable import swiftCoin

final class swiftCoinTests: XCTestCase {

    func testDecodeCoinsIntoArray_marketCap_descending() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinsData)
            XCTAssertTrue(coins.count > 0)
            XCTAssertTrue(coins.count == 5)
            XCTAssertTrue(coins[0].id == "bitcoin")
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
