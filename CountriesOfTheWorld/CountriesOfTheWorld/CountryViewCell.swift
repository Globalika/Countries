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

    var indentView: CellDecoratorView = {
        var view = CellDecoratorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = Constants.decoratorViewCornerRadius
        view.shadowColor = Constants.decoratorShadowColor
        view.shadowOffset = Constants.decoratorShadowOffset
        view.shadowRadius = Constants.decoratorShadowRadius
        view.shadowOpacity = Constants.decoratorShadowOpacity
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
        configureCellView()
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
    func configureCellView() {
        addSubview(indentView)
        setIndentViewConstraints()
        configureIndentView()
    }

    func setIndentViewConstraints() {
        NSLayoutConstraint.activate([
            indentView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.indentViewInsets.top),
            indentView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                constant: Constants.indentViewInsets.left),
            indentView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                 constant: Constants.indentViewInsets.right),
            indentView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                constant: Constants.indentViewInsets.bottom)
        ])
    }

    func configureIndentView() {
        indentView.addSubview(horizontalStackView)
        setHorizontalStackViewConstraints()
        configureHorizontalStackView()
    }

    func setHorizontalStackViewConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: indentView.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: indentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: indentView.bottomAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: indentView.trailingAnchor)
        ])
    }

    func configureHorizontalStackView() {
        horizontalStackView.addArrangedSubview(flagImageView)
        setFlagImageConstraints()
        horizontalStackView.addArrangedSubview(labelVerticalStackView)
        setLabelVerticalStackViewConstraints()
        configureLabelVerticalStackView()
    }

    func configureLabelVerticalStackView() {
        labelVerticalStackView.addArrangedSubview(countryNameLabel)
        labelVerticalStackView.addArrangedSubview(countryCapitalLabel)
        labelVerticalStackView.addArrangedSubview(countryContinentLabel)
        setLabelsConstraints()
    }

    func setLabelVerticalStackViewConstraints() {
        NSLayoutConstraint.activate([
            labelVerticalStackView.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor),
            labelVerticalStackView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            labelVerticalStackView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
            labelVerticalStackView.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor)
        ])
    }

    func setFlagImageConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.leftAnchor.constraint(equalTo: horizontalStackView.leftAnchor,
                                                constant: Constants.flagViewInsets.left),
            flagImageView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor,
                                               constant: Constants.flagViewInsets.top),
            flagImageView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,
                                                  constant: Constants.flagViewInsets.bottom),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagViewWidth)
        ])
    }

    func setLabelsConstraints() {
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: labelVerticalStackView.topAnchor),
            countryNameLabel.leftAnchor.constraint(equalTo: labelVerticalStackView.leftAnchor),
            countryNameLabel.rightAnchor.constraint(equalTo: labelVerticalStackView.rightAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            countryCapitalLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor),
            countryCapitalLabel.leftAnchor.constraint(equalTo: labelVerticalStackView.rightAnchor),
            countryCapitalLabel.rightAnchor.constraint(equalTo: labelVerticalStackView.rightAnchor),
            countryCapitalLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            countryContinentLabel.topAnchor.constraint(equalTo: countryCapitalLabel.bottomAnchor),
            countryContinentLabel.leftAnchor.constraint(equalTo: labelVerticalStackView.rightAnchor),
            countryContinentLabel.rightAnchor.constraint(equalTo: labelVerticalStackView.rightAnchor),
            countryContinentLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    private struct Constants {
        static let indentViewInsets = UIEdgeInsets(top: 10, left: 30, bottom: -10, right: -30)
        static let flagViewInsets = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
        static let flagViewWidth: CGFloat = 80
        static let notApplicableField = "N-A"
        static let labelHeight: CGFloat = 33
        static let horizontalStackSpacing: CGFloat = 20
        static let labelVerticalStackSpacing: CGFloat = 20
        static let decoratorViewCornerRadius: CGFloat = 15
        static let decoratorShadowColor = UIColor(red: 0, green: 0, blue: 0)
        static let decoratorShadowOffset = CGSize(width: 0, height: 4)
        static let decoratorShadowRadius: CGFloat = 4
        static let decoratorShadowOpacity: Float = 0.2
    }
}
