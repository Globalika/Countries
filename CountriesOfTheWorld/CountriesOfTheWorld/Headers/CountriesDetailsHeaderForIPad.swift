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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func configureTableHeader() {
        backgroundColor = .white
        addSubview(countryImageView)
        setworldImageConstraints()
        addSubview(flagsImageView)
        setFlagsImageConstraints()
    }

    func setworldImageConstraints() {
        NSLayoutConstraint.activate([
            countryImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                  constant: Constants.countryImageTopInset),
            countryImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            countryImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryImageView.heightAnchor.constraint(equalToConstant: Constants.countryImageHeight)
        ])
    }

    func setFlagsImageConstraints() {
        NSLayoutConstraint.activate([
            flagsImageView.topAnchor.constraint(equalTo: countryImageView.bottomAnchor,
                                                constant: Constants.flagImageTopInset),
            flagsImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            flagsImageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            flagsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                   constant: Constants.flagImageBottomInset)
        ])
    }

    private struct Constants {
        static let flagsImage = UIImage(named: "flags")
        static let countryImageTopInset: CGFloat = 10
        static let countryImageHeight: CGFloat = 110
        static let flagImageTopInset: CGFloat = -40
        static let flagImageBottomInset: CGFloat = -10
    }
}
