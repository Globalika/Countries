//
//  CountriesControllerUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 30.12.2021.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesControllerIPhoneUnitTests: XCTestCase {

    var sut: CountriesController!
    var window: UIWindow!
    var networkManager = NetworkManager(client: ApolloMock())

    override func setUp() {
        window = UIWindow()
        sut = CountriesController(networkManager, .iPhone)
        window.rootViewController = sut
        super.setUp()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    func testHeightForRow() {
        let expectedHeight: CGFloat = 185
        let indexPath = IndexPath()
        let actualHeight = sut.tableView(sut.tableView, heightForRowAt: indexPath)
        XCTAssertEqual(expectedHeight, actualHeight)
    }

    func testHeaghtForHeaderInSectionForIPhone() {
        let expectedHeight: CGFloat = 160
        let actualHeight = sut.tableView(sut.tableView, heightForHeaderInSection: 0)
        XCTAssertEqual(expectedHeight, actualHeight)
    }

    func testCellForRowWhenWithApolloMock() {
        sut.loadData()
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
        sut.loadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }

    func testTableViewCellType() {
        sut.loadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        let isCurrentType = cell is CountryViewCell
        XCTAssertTrue(isCurrentType)
    }

    func testNumbersOfRowInSectionWithNoElements() {
        sut.loadData()
        let expectednumberOfRows = 4
        let actualnumberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(expectednumberOfRows, actualnumberOfRows)
    }

    func testNavigatorBarTitle() {
        sut.configureTableView()
        XCTAssertEqual(sut.navigationItem.title, "Country List")
    }

    func testSearchBarController() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.navigationItem.searchController, sut.searchController)
    }

    func testLoadMockData() {
        sut.loadData()
        XCTAssertTrue(sut.countries.count == 4)
    }

    func testSearchBarWithText() {
        sut.loadData()
        sut.searchBar(sut.searchController.searchBar,
                      textDidChange: "Ukraine")
        XCTAssertTrue(sut.filteredCountries?.count == 4)
    }

    func testSearchBarWithoutText() throws {
        sut.loadData()
        sut.searchBar(sut.searchController.searchBar,
                      textDidChange: "")
        let isFilterCountriesEmpty = try XCTUnwrap(sut.filteredCountries?.isEmpty)
        XCTAssertTrue(isFilterCountriesEmpty)
    }
}

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
