//
//  CountryViewCellUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 24.12.2021.
//

import XCTest
@testable import CountriesOfTheWorld

class CountryViewCellUnitTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testCellSubviewsOrder() {
        let cell = CountryViewCell()
        let expectedSubviews: [UIView] = [cell.indentView]
        let actualSubviews = cell.subviews

        XCTAssertEqual(type(of: cell.indentView),
                       type(of: cell.subviews))
    }
}
