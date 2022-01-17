//
//  SubviewsOrderUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 03.01.2022.
//

import GradientView
import XCTest
@testable import CountriesOfTheWorld

class SubviewsOrderUnitTests: XCTestCase {

    func testDecoratorSubviewsOrder() {
        let cellDecorator = CellDecoratorView()
        XCTAssertTrue(cellDecorator.subviews[1] is GradientView)
        XCTAssertEqual(cellDecorator.subviews.count, 2)
    }

    func testPlaceHolderSubviewsOrder() {
        let placeHolder = DetailsFieldPlaceHolderView()
        XCTAssertTrue(placeHolder.subviews[0] is UIStackView)
        XCTAssertTrue(placeHolder.subviews[1] is UILabel)
        XCTAssertTrue(placeHolder.subviews[0].subviews[0] is UIImageView)
        XCTAssertTrue(placeHolder.subviews[0].subviews[0] is UIImageView)
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

    func testCountriesHeaderSubviewsOrder() {
        let header = CountriesHeaderView()
        XCTAssertTrue(header.contentView.subviews[0] is UIImageView)
        XCTAssertTrue(header.contentView.subviews[1] is UILabel)
    }

    func testCountryDetailsHeaderSubviews() {
        let header = CountriesDetailsHeader()
        XCTAssertEqual(header.subviews.count, 2)
        XCTAssertTrue(header.subviews.allSatisfy({ $0 is UIImageView }))
    }
}
