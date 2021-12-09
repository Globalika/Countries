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
        configureTableHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func configureTableHeader() {
        backgroundColor = Constants.headerBackgroundColor
        addSubview(worldImageView)
        setworldImageConstraints()
        addSubview(flagsImageView)
        setFlagsImageConstraints()
    }

    func setworldImageConstraints() {
        NSLayoutConstraint.activate([
            worldImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                constant: Constants.worldImageTopInset),
            worldImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            worldImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            worldImageView.heightAnchor.constraint(equalToConstant: Constants.worldImageHeight)
        ])
    }

    func setFlagsImageConstraints() {
        NSLayoutConstraint.activate([
            flagsImageView.topAnchor.constraint(equalTo: worldImageView.bottomAnchor,
                                                constant: Constants.flagsImageTopInset),
            flagsImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            flagsImageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            flagsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                   constant: Constants.flagsImageBottomInset)
        ])
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let flagsImage = UIImage(named: "flags")
        static let worldImageTopInset: CGFloat = 10
        static let worldImageHeight: CGFloat = 110
        static let flagsImageTopInset: CGFloat = -40
        static let flagsImageBottomInset: CGFloat = -10
        static let headerBackgroundColor = UIColor(rgb: 0xF1F1F1)
    }
}
