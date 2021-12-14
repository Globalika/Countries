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
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
