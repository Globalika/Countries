//
//  CountriesControllerIPadUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesControllerIPadUnitTests: XCTestCase {
    var sut: CountriesController!
    var window: UIWindow!
    var networkManager = NetworkManager(client: ApolloMock())

    override func setUp() {
        window = UIWindow()
        sut = CountriesController(networkManager, .iPad)
        window.rootViewController = sut
        super.setUp()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    func testHeaghtForHeaderInSectionForIPad() {
        let expectedHeight: CGFloat = 0
        let actualHeight = sut.tableView(sut.tableView, heightForHeaderInSection: 0)
        XCTAssertEqual(expectedHeight, actualHeight)
    }

    func testTableIPadViewHeaderType() {
        let header = sut.tableView(sut.tableView, viewForHeaderInSection: 0)
        let isCurrentType = header != nil
        XCTAssertTrue(isCurrentType)
    }
}
