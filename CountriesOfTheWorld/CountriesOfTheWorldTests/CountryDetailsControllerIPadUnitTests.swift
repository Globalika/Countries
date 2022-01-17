//
//  CountryDetailsControllerIPadUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesDetailsControllerIPadUnitTests: XCTestCase {

    typealias Continent = CountriesQuery.Data.Country.Continent
    var sut: CountryDetailsController!
    var networkManager = NetworkManager(client: ApolloMock())
    var window: UIWindow!

    override func setUp() {
        window = UIWindow()
        sut = CountryDetailsController(networkManager, .iPad)
        window.rootViewController = sut
        super.setUp()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    func testiPadControllerSubviewsOrderWithoutData() {
        sut.fillDetailsViewWithCountryQuery()
        sut.viewDidLoad()
        XCTAssertEqual(sut.view.subviews.count, 1)
    }

    func testIPadControllerSubviewsOrderWithData() {
        sut.loadData(code: "UA")
        sut.fillDetailsViewWithCountryQuery()
        sut.viewDidLoad()
        XCTAssertTrue(sut.view.subviews[0] is CountriesDetailsHeader)
        XCTAssertTrue(sut.view.subviews[1] is UIScrollView)
        XCTAssertTrue(sut.view.subviews[1].subviews[1] is UIImageView)
        XCTAssertTrue(sut.view.subviews[1].subviews[2] is UIStackView)
    }
}
