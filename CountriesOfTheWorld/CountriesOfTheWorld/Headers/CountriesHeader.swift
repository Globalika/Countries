//
//  CountriesHeader.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 03.12.2021.
//

import Foundation
import UIKit

class CountriesHeaderView: UITableViewHeaderFooterView {
    static let identifier = "countriesTableHeader"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.headerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.headerLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureTableHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func configureTableHeader() {
        contentView.backgroundColor = Constants.headerBackgroundColor
        contentView.addSubview(imageView)
        setImageConstraints()
        contentView.addSubview(headerLabel)
        setLabelConstraints()
    }

    func setImageConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                               constant: Constants.subviewsTopInset),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                             constant: Constants.subviewsTopInset),
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

    private struct Constants {
        static let subviewsTopInset: CGFloat = -15
        static let headerBackgroundColor = UIColor(rgb: 0xF1F1F1)
        static let headerLabelText = "Choose a card :)"
        static let headerImage = UIImage(named: "world")
    }
}
