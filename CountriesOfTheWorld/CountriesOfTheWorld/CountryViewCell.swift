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
            Constants.cellGradientFirstColor,
            Constants.cellGradientSecondColor
        ]
        gradient.locations = [Constants.firstColorGradientStopLocation,
                              Constants.secondColorGradientStopLocation]
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
        stack.spacing = Constants.horizontalStackSpacing
        return stack
    }()

    var labelVerticalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = Constants.labelVerticalStackSpacing
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
        setCellViewConstraints()
        configureCellView()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = indentView.bounds
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
    func configureCellView() {
        addSubview(indentView)
        setIndentViewConstraints()
        configureIndentView()
    }

    func setIndentViewConstraints() {
        NSLayoutConstraint.activate([
            indentView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.indentViewTopMargin),
            indentView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Constants.indentViewLeftMargin),
            indentView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: Constants.indentViewRightMargin),
            indentView.heightAnchor.constraint(equalToConstant: Constants.indentViewHeight)
        ])
    }

    func configureIndentView() {
        indentView.layer.insertSublayer(gradient, at: 0)
        indentView.addSubview(horizontalStackView)
        setHorizontalStackViewConstraints()
        configureHorizontalStackView()
    }

    func setHorizontalStackViewConstraints() {
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 0,
                                                         left: 0,
                                                         bottom: 0,
                                                         right: 0)
    }

    func configureHorizontalStackView() {
        // TODO configure horizontal stack view
    }

    func setCellViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Constants.cellHeight)
        ])
    }

    func setFlagImageConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            flagImageView.topAnchor.constraint(equalTo: self.topAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            flagImageView.widthAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }

    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            countryNameLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            countryCapitalLabel.topAnchor.constraint(equalTo: self.countryNameLabel.bottomAnchor),
            countryCapitalLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryCapitalLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryCapitalLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            countryContinentLabel.topAnchor.constraint(equalTo: self.countryCapitalLabel.bottomAnchor),
            countryContinentLabel.leftAnchor.constraint(equalTo: self.flagImageView.rightAnchor),
            countryContinentLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            countryContinentLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    private struct Constants {
        static let cellHeight: CGFloat = 185
        static let notApplicableField = "N-A"
        static let cellGradientFirstColor = UIColor(rgb: 0xFFE485).cgColor
        static let cellGradientSecondColor = UIColor(rgb: 0xBA7B00).cgColor
        static let firstColorGradientStopLocation: NSNumber = 0.5
        static let secondColorGradientStopLocation: NSNumber = 1.0
        static let labelHeight: CGFloat = 33
        static let indentViewHeight: CGFloat = 160
        static let indentViewTopMargin: CGFloat = 10
        static let indentViewLeftMargin: CGFloat = 30
        static let indentViewRightMargin: CGFloat = -30
        static let horizontalStackSpacing: CGFloat = 20
        static let labelVerticalStackSpacing: CGFloat = 20
    }
}
