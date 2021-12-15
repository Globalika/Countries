//
//  UIStackViewExtensions.swift
//  CountriesOfTheWorld
//
//  Created by Khrystyna Matasova on 14.12.2021.
//

import Foundation
import UIKit

extension UIStackView {

    func removeAllArrangedSubviews() {
        for subview in self.subviews {
               subview.removeFromSuperview()
           }
    }
}
