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
        self.subviews.forEach {
            $0.subviews.isEmpty ?
            $0.removeFromSuperview() :
            $0.removeAllSubviews()
        }
    }
}
