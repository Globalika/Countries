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

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
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
        static let notApplicableField: String = "N-A"
    }
}
