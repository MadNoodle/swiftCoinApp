//
//  CoinsViewModelTests.swift
//  swiftCoinTests
//
//  Created by User on 5.1.2024.
//

import XCTest
@testable import swiftCoin

class CoinsViewModelTest: XCTestCase {
    
    // MARK: - Properties
    private var service: MockCoinService?
    
    // MARK: - LifeCyle
    override func setUp() {
        self.service = MockCoinService()
    }
    
    override func tearDown() {
        self.service = nil
    }
    
    // MARK: - Tests
    func test_init() {
        let viewModel = self.makeSut()
        
        XCTAssertNotNil(viewModel, "the viewModel should not be nil")
    }
    
    func testSuccessfulfCoinsFetch() async {
        let viewModel = self.makeSut()
        await viewModel.fetchCoins()
        
        XCTAssertTrue(viewModel.coins.count > 0)
        XCTAssertTrue(viewModel.coins.count == 5)
        XCTAssertTrue(viewModel.coins[0].id == "bitcoin")
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
    }
    
    func testSuccessfulCoinsFetchWithInvalidJSON() async {
        let viewModel = self.makeSut(data: mockCoinsDataWithInvalidData)
        await viewModel.fetchCoins()
        
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testThrowsInvalidDataError() async {
        let viewModel = self.makeSut(error: .invalidData)

        await viewModel.fetchCoins()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(
            viewModel.errorMessage,
            CoinAPIError.invalidData.customDescription
        )
    }
    
    func testThrowsInvalidStatusCode() async {
        let viewModel = self.makeSut(error: .invalidStatusCode(statusCode: 404))
        await viewModel.fetchCoins()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(
            viewModel.errorMessage,
            CoinAPIError.invalidStatusCode(statusCode: 404).customDescription
        )
    }
    
    // MARK: - Helpers
    private func makeSut(data: Data? = nil, error: CoinAPIError? = nil) -> CoinsViewModel {
        guard let service = self.service else {
            XCTFail("Service should not be nil")
            return CoinsViewModel(service: MockCoinService())
        }
        
        if let data {
            service.mockData = data
        }
        
        if let error {
            service.mockError = error
        }
        
        return CoinsViewModel(service: service)
    }
}
