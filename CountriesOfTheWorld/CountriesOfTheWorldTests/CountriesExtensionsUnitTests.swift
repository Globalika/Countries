//
//  CountriesExtensionsUnitTests.swift
//  CountriesTests
//
//  Created by Volodymyr Seredovych on 23.11.2021.
//

import XCTest
@testable import CountriesOfTheWorld

class CountriesExtensionsUnitTests: XCTestCase {
    func testUILableExtensionAttributedTextString() {
        let expectedLabelText = "description\ndata"
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
        XCTAssertEqual(label.attributedText?.string, expectedLabelText)
    }

    func testStackViewRemoveAllSubviewExtension() {
        let view = UIView()
        view.addSubview(UIView())
        view.addSubview(UIView())
        XCTAssertFalse(view.subviews.isEmpty)
        view.removeAllSubviews()
        XCTAssertTrue(view.subviews.isEmpty)
    }
}
