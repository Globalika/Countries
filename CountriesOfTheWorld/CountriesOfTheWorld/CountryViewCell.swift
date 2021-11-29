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
    var image = UIImage() {
        didSet {
            flagImageView.image = image
        }
    }
    func updateCell(country: CountriesQuery.Data.Country) {
        if let url = URL(string: "https://flagcdn.com/256x192/\(country.code.lowercased()).png") {
            self.downloadImage(from: url)
        } else {
            print("error: invalid image url")
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

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.flagImageView.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}
