//
//  CountriesDetailsHeaderForIPad.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 01.01.2022.
//

import Foundation
import UIKit

class CountriesDetailsHeaderForIPad: UIView {
    let countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.flagsImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private struct Constants {
        static let flagsImage = UIImage(named: "flags")
    }
}
