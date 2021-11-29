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

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func updateCell(country: CountriesQuery.Data.Country) {
        if let image = UIImage(named: "32423\(country.code.lowercased())") {
            self.flagImageView.image = image
        } else {
            self.flagImageView.image = UIImage()
        }
        self.countryNameLabel.text = country.name
        self.countryCapitalLabel.text = country.capital ?? Constants.notApplicableField
        self.countryContinentLabel.text = country.continent.name
    }

    func setCellConstraints() {
        flagImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        flagImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        flagImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        countryNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        countryNameLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryNameLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true

        countryCapitalLabel.topAnchor.constraint(equalTo: self.countryNameLabel.bottomAnchor).isActive = true
        countryCapitalLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryCapitalLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryCapitalLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true

        countryContinentLabel.topAnchor.constraint(equalTo: self.countryCapitalLabel.bottomAnchor).isActive = true
        countryContinentLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryContinentLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryContinentLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }

    private struct Constants {
        static let notApplicableField: String = "N-A"
    }
}
