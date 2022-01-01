//
//  CountryViewCellUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 01.01.2022.
//

import XCTest
import GradientView
@testable import CountriesOfTheWorld

class CountryViewCellUnitTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testCellSubviewsOrder() {
        let cell = CountryViewCell()
        XCTAssertTrue(cell.subviews[0] is CellDecoratorView)
        XCTAssertTrue(cell.subviews[0].subviews[1] is GradientView)
        XCTAssertTrue(cell.subviews[0].subviews[2] is UIStackView)
        XCTAssertTrue(cell.subviews[0].subviews[2].subviews[0] is UIImageView)
        XCTAssertTrue(cell.subviews[0].subviews[2].subviews[1] is UIStackView)
        XCTAssertTrue(cell.subviews[0].subviews[2].subviews[1].subviews[0] is UILabel)
        XCTAssertTrue(cell.subviews[0].subviews[2].subviews[1].subviews[1] is UILabel)
        XCTAssertTrue(cell.subviews[0].subviews[2].subviews[1].subviews[2] is UILabel)
    }
}
