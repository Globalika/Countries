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

    func testSetSelectedTrue() {
        let cell = CountryViewCell()
        cell.currentDevice = .iPad
        cell.setSelected(true, animated: false)
        XCTAssertTrue(cell.selectedCellBorderView.isDescendant(of: cell.indentView))
    }

    func testSetSelectedFalse() {
        let cell = CountryViewCell()
        cell.setSelected(false, animated: false)
        XCTAssertFalse(cell.selectedCellBorderView.isDescendant(of: cell.indentView))
    }
}
