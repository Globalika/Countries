//
//  UILabelExtensions.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 09.12.2021.
//

import UIKit

extension UILabel {
    func setAttributedText(descriptionText: String,
                           descriptionTextFont: UIFont,
                           dataText: String,
                           dataTextFont: UIFont) {
        let fullText = NSMutableAttributedString(string: "")
        let descriptionText = NSMutableAttributedString(string: descriptionText)
        let descriptionTextFont = descriptionTextFont
        let descriptionTextRange = NSRange(location: 0, length: descriptionText.length)
        descriptionText.addAttribute(.font,
                                value: descriptionTextFont,
                                range: descriptionTextRange)
        let dataText = NSMutableAttributedString(string: dataText)
        let dataTextFont = dataTextFont
        let dataTextRange = NSRange(location: 0, length: dataText.length)
        dataText.addAttribute(.font,
                                value: dataTextFont,
                                range: dataTextRange)
        fullText.append(descriptionText)
        fullText.append(NSMutableAttributedString(string: UILabel.Constants.newLine))
        fullText.append(dataText)
        self.attributedText = fullText
    }
    private struct Constants {
        static let newLine = "\n"
    }
}
