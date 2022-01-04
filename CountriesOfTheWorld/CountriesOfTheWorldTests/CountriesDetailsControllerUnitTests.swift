//
//  CountriesDetailsControllerUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 03.01.2022.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesDetailsControllerUnitTests: XCTestCase {

    typealias Continent = CountriesQuery.Data.Country.Continent
    var sut: CountryDetailsController!
    var networkManager = NetworkManager(client: ApolloMock())
    var window: UIWindow!

    override func setUp() {
        window = UIWindow()
        sut = CountryDetailsController(networkManager, .iPhone)
        window.rootViewController = sut
        super.setUp()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    func testNavigatorBarTitle() {
        sut.configureDetailsView()
        XCTAssertEqual(sut.navigationItem.title, "Country List")
    }

    func testControllerSubviewsOrder() {
        sut.configureDetailsView()
        XCTAssertTrue(sut.view.subviews[0] is CountriesDetailsHeader)
        XCTAssertTrue(sut.view.subviews[1] is UIScrollView)
        XCTAssertTrue(sut.view.subviews[1].subviews[1] is UIImageView)
        XCTAssertTrue(sut.view.subviews[1].subviews[2] is UIStackView)
    }

    func testScrollViewRefreshControl() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.refrechControl, sut.scrollView.refreshControl)
    }

    func testAddLabelsToStack() {
        sut.countryBasic = CountryLite(code: "UA",
                                       name: "Ukraine",
                                       capital: "Kyiv",
                                       continent: ContinentModel(name: "Europe"))
        sut.fillDetailsViewWithData()
        sut.addLabelsToStackView()
        XCTAssertTrue(sut.stackView.subviews.allSatisfy({ $0 is DetailsFieldPlaceHolderView }))
        XCTAssertTrue(sut.stackView.subviews.count == 3)
    }

    func testLoadMockData() {
        sut.loadData(code: "UA")
        sut.fillDetailsViewWithCountryQuery()
        sut.addLabelsToStackView()
        XCTAssertTrue(sut.stackView.subviews.allSatisfy({ $0 is DetailsFieldPlaceHolderView }))
        XCTAssertTrue(sut.stackView.subviews.count == 6)
    }
}
