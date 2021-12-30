//
//  CountriesExtensionsUnitTests.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 23.12.2021.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesExtensionsUnitTests: XCTestCase {

    func testUIColorHexExtensionWhiteColor() {
        let expectedColor = UIColor(red: 1.0,
                                    green: 1.0,
                                    blue: 1.0,
                                    alpha: 1.0)
        let actualColor = UIColor(rgb: 0xFFFFFF)
        XCTAssertEqual(expectedColor, actualColor)
    }

    func testUIColorRGBExtensionWhiteColor() {
        let expectedColor = UIColor(red: 1.0,
                                    green: 1.0,
                                    blue: 1.0,
                                    alpha: 1.0)
        let actualColor = UIColor(red: 255, green: 255, blue: 255)
        XCTAssertEqual(expectedColor, actualColor)
    }

    func testUILableExtensionAttributedText() {
        let label = UILabel()
        let descriptionText = NSMutableAttributedString(string: "description")
        let descriptionTextFont = UIFont.systemFont(ofSize: 15,
                                                      weight: UIFont.Weight.thin)
        let dataText = NSMutableAttributedString(string: "data")
        let dataTextFont = UIFont.systemFont(ofSize: 20,
                                                     weight: UIFont.Weight.bold)
        label.setAttributedText(descriptionText: descriptionText.string,
                                descriptionTextFont: descriptionTextFont,
                                dataText: dataText.string,
                                dataTextFont: dataTextFont)
        XCTAssertEqual(label.attributedText?.string, "description\ndata")
    }
}
