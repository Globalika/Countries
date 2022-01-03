//
//  CountriesDetailsControllerUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 03.01.2022.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesDetailsControllerUnitTests: XCTestCase {

    var sut: CountryDetailsController!
    var window: UIWindow!

    override func setUp() {
        window = UIWindow()
        sut = CountryDetailsController(NetworkManager(client: ApolloMock()))
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

    func testCellSubviewsOrder() {
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
        sut.countryBasic = CountriesQuery.Data.Country(code: "UA",
                                                       name: "Ukraine",
                                                       capital: "Kyiv", continent: CountriesQuery.Data.Country.Continent(name: "Europe"))
        sut.fillDetailsViewWithData()
        sut.addLabelsToStackView()
        XCTAssertTrue(sut.stackView.subviews.allSatisfy({ $0 is DetailsFieldPlaceHolderView }))
        XCTAssertTrue(sut.stackView.subviews.count == 3)
    }
}
