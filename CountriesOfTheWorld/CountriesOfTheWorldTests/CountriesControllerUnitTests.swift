//
//  CountriesControllerUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 30.12.2021.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesControllerUnitTests: XCTestCase {

    typealias Country = CountriesQuery.Data.Country
    var sut: CountriesController!
    var window: UIWindow!
    let country = Country(code: "UA",
                          name: "Ukraine",
                          capital: "Kyiv",
                          continent: Country.Continent(name: "Europe"))
    override func setUp() {
        window = UIWindow()
        sut = CountriesController(NetworkManager(client: ApolloMock()))
        window.rootViewController = sut
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHeightForRow() {
        let expectedHeight: CGFloat = 185
        let indexPath = IndexPath()
        let actualHeight = sut.tableView(sut.tableView, heightForRowAt: indexPath)
        XCTAssertEqual(expectedHeight, actualHeight)
    }

    func testHeaghtForHeaderInSectionForIPhone() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let expectedHeight: CGFloat = 160
            let actualHeight = sut.tableView(sut.tableView, heightForHeaderInSection: 0)
            XCTAssertEqual(expectedHeight, actualHeight)
        }
    }

    func testHeaghtForHeaderInSectionForIPad() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let expectedHeight: CGFloat = 0
            let actualHeight = sut.tableView(sut.tableView, heightForHeaderInSection: 0)
            XCTAssertEqual(expectedHeight, actualHeight)
        }
    }

    func testCellForRowWhenWithApolloMock() {
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }

    func testTableViewHeaderNotNil() {
        let header = sut.tableView(sut.tableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(header)
    }

    func testTableViewHeaderType() {
        let header = sut.tableView(sut.tableView, viewForHeaderInSection: 0)
        let isCurrentType = header is CountriesHeaderView
        XCTAssertTrue(isCurrentType)
    }

    func testTableViewCellNotNil() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }

    func testTableViewCellType() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        let isCurrentType = cell is CountryViewCell
        XCTAssertTrue(isCurrentType)
    }

    func testNumbersOfRowInSectionWithNoElements() {
        let expectedNumber = 4
        let actualNumber = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(expectedNumber, actualNumber)
    }
}
