//
//  UIViewExtensions.swift
//  CountriesOfTheWorld
//
//  Created by Khrystyna Matasova on 14.12.2021.
//

import Foundation
import UIKit

extension UIView {
    func removeAllSubviews() {
        self.subviews.forEach({
            if !($0 is UILayoutSupport) {
                $0.removeAllSubviews()
                $0.removeFromSuperview()
            }
        })
    }
}
