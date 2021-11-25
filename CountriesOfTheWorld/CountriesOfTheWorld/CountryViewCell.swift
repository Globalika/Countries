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
    var flagImage: UIImage?
    var countryName: String?
    var countryCapital: String?
    var countryContinent: String?

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var countryNameView: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    var countryCapitalView: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    var countryContinentView: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .lightGray
        self.addSubview(flagImageView)
        self.addSubview(countryNameView)
        self.addSubview(countryCapitalView)
        self.addSubview(countryContinentView)

        setConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let image = flagImage {
            flagImageView.image = image
        }

        if let countryName = countryName {
            countryNameView.text = countryName
        }

        if let countryCapital = countryCapital {
            countryCapitalView.text = countryCapital
        }

        if let countryContinent = countryContinent {
            countryContinentView.text = countryContinent
        }
    }
    
    func setConstrains() {
        flagImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        flagImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        flagImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        countryNameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        countryNameView.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryNameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryNameView.heightAnchor.constraint(equalToConstant: 33).isActive = true

        countryCapitalView.topAnchor.constraint(equalTo: self.countryNameView.bottomAnchor).isActive = true
        countryCapitalView.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryCapitalView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryCapitalView.heightAnchor.constraint(equalToConstant: 33).isActive = true

        countryContinentView.topAnchor.constraint(equalTo: self.countryCapitalView.bottomAnchor).isActive = true
        countryContinentView.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor).isActive = true
        countryContinentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countryContinentView.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }
}
