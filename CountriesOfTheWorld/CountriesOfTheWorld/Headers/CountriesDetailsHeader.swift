//
//  CountriesDetailsHeader.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 09.12.2021.
//

import Foundation
import UIKit

class CountriesDetailsHeader: UIView {
    let worldImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.worldImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.flagsImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let flagsImage = UIImage(named: "flags")
    }
}
