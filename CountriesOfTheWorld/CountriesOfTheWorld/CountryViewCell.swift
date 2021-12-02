//
//  CountryViewCell.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Foundation
import UIKit

class CountryViewCell: UITableViewCell {
    static let identifier = "CountryViewCell"

    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(rgb: Constants.cellGradientFirstColor).cgColor,
            UIColor(rgb: Constants.cellGradientSecondColor).cgColor
        ]
        gradient.locations = [0.0, 0.5]
        return gradient
    }()

    var indentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var horizontalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    var labelVerticalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var countryNameLabel: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    var countryCapitalLabel: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    var countryContinentLabel: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .lightGray
        self.addSubview(flagImageView)
        self.addSubview(countryNameLabel)
        self.addSubview(countryCapitalLabel)
        self.addSubview(countryContinentLabel)

        setCellConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
}

extension CountryViewCell {
    func updateCell(country: CountriesQuery.Data.Country) {
        if let image = UIImage(named: "\(country.code.lowercased())") {
            self.flagImageView.image = image
        } else {
            self.flagImageView.image = UIImage()
        }
        self.countryNameLabel.text = country.name
        self.countryCapitalLabel.text = country.capital ?? Constants.notApplicableField
        self.countryContinentLabel.text = country.continent.name
    }
}

extension CountryViewCell {
    func setCellConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            flagImageView.topAnchor.constraint(equalTo: self.topAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            flagImageView.widthAnchor.constraint(equalTo: self.heightAnchor),

            countryNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            countryNameLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 33),

            countryCapitalLabel.topAnchor.constraint(equalTo: self.countryNameLabel.bottomAnchor),
            countryCapitalLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryCapitalLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryCapitalLabel.heightAnchor.constraint(equalToConstant: 33),

            countryContinentLabel.topAnchor.constraint(equalTo: self.countryCapitalLabel.bottomAnchor),
            countryContinentLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryContinentLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryContinentLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }

    private struct Constants {
        static let notApplicableField = "N-A"
        static let cellGradientFirstColor = 0xFFE485
        static let cellGradientSecondColor = 0xBA7B00
    }
}
