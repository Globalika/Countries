//
//  UIStackViewExtensions.swift
//  CountriesOfTheWorld
//
//  Created by Khrystyna Matasova on 14.12.2021.
//

import Foundation
import UIKit

extension UIStackView {

    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview }
    }
}