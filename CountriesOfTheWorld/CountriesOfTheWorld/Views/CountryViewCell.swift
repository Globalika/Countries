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

    var selectedCellBorderView: UIView = {
        var view = UIView()
        view.layer.borderWidth = Constants.selectedCellBorderWidth
        view.layer.cornerRadius = Constants.selectedCellBorderCornerRadius
        view.layer.borderColor = Constants.selectedCellBorderColor
        return view
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            selectedCellBorderView.frame = indentView.bounds
            indentView.addSubview(selectedCellBorderView)
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                selectedCellBorderView.removeFromSuperview()
            }
        }
    }

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
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = Constants.labelVerticalStackSpacing
        return stack
    }()

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    static func setLabelProperties(label: UILabel) {
        label.numberOfLines = Constants.allowedNumberOfLinesToWrap
        label.minimumScaleFactor = Constants.labelMinimumScaleFactor
        label.adjustsFontSizeToFitWidth = true
    }

    var countryNameLabel: UILabel = {
        var labelView = UILabel()
        setLabelProperties(label: labelView)
        return labelView
    }()

    var countryCapitalLabel: UILabel = {
        var labelView = UILabel()
        setLabelProperties(label: labelView)
        return labelView
    }()

    var countryContinentLabel: UILabel = {
        var labelView = UILabel()
        setLabelProperties(label: labelView)
        return labelView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellView()
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
        countryNameLabel.setAttributedText(
            descriptionText: Constants.countryNameDescriptionText,
            descriptionTextFont: .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                             weight: Constants.labelDescriptionFontWeight),
            dataText: country.name,
            dataTextFont: .systemFont(ofSize: Constants.labelDataFontSize,
                                      weight: Constants.labelDataFontWeight)
        )
        countryCapitalLabel.setAttributedText(
            descriptionText: Constants.countryCapitalDescriptionText,
            descriptionTextFont: .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                             weight: Constants.labelDescriptionFontWeight),
            dataText: country.capital ?? Constants.notApplicableField,
            dataTextFont: .systemFont(ofSize: Constants.labelDataFontSize,
                                      weight: Constants.labelDataFontWeight)
        )
        countryContinentLabel.setAttributedText(
            descriptionText: Constants.countryContinentDescriptionText,
            descriptionTextFont: .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                             weight: Constants.labelDescriptionFontWeight),
            dataText: country.continent.name,
            dataTextFont: .systemFont(ofSize: Constants.labelDataFontSize,
                                      weight: Constants.labelDataFontWeight)
        )
    }

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
            horizontalStackView.trailingAnchor.constraint(equalTo: indentView.trailingAnchor,
                                                          constant: Constants.horizontalStackRightInset)
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
    }

    func setLabelVerticalStackViewConstraints() {
        NSLayoutConstraint.activate([
            labelVerticalStackView.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor,
                                                            constant: Constants.verticalStackInsets.left),
            labelVerticalStackView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor,
                                                        constant: Constants.verticalStackInsets.top),
            labelVerticalStackView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,
                                                           constant: Constants.verticalStackInsets.bottom),
            labelVerticalStackView.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor,
                                                             constant: Constants.verticalStackInsets.right)
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

    private struct Constants {
        static let horizontalStackRightInset: CGFloat = -10
        static let indentViewInsets = UIEdgeInsets(top: 10, left: 30, bottom: -10, right: -30)
        static let flagViewInsets = UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
        static let verticalStackInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
        static let verticalStackMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        static let flagViewWidth: CGFloat = 80
        static let notApplicableField = "N-A"
        static let horizontalStackSpacing: CGFloat = 20
        static let labelVerticalStackSpacing: CGFloat = 5
        static let decoratorViewCornerRadius: CGFloat = 15
        static let decoratorShadowColor = UIColor(red: 0, green: 0, blue: 0)
        static let decoratorShadowOffset = CGSize(width: 0, height: 4)
        static let decoratorShadowRadius: CGFloat = 4
        static let decoratorShadowOpacity: Float = 0.2
        static let allowedNumberOfLinesToWrap = 0
        static let labelMinimumScaleFactor = 0.8
        static let labelDescriptionFontSize: CGFloat = 9
        static let labelDescriptionFontWeight: UIFont.Weight = .thin
        static let labelDataFontSize: CGFloat = 15
        static let labelDataFontWeight: UIFont.Weight = .bold
        static let countryNameDescriptionText = "Country"
        static let countryCapitalDescriptionText = "Capital"
        static let countryContinentDescriptionText = "Continent"
        static let selectedCellBorderWidth: CGFloat = 2
        static let selectedCellBorderColor = UIColor.green.cgColor
        static let selectedCellBorderCornerRadius: CGFloat = 15
    }
}
