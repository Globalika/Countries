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

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.headerLabelFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func layoutSubviews() {
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = Constants.headerBackgroundColor
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureTableHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func configureTableHeader() {
        contentView.addSubview(imageView)
        setImageConstraints()
        contentView.addSubview(headerLabel)
        setLabelConstraints()
    }

    func setImageConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }

    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                constant: Constants.labelBottomInset)
        ])
    }

    private struct Constants {
        static let headerLabelFont: CGFloat = 40
        static let imageHeight: CGFloat = 100
        static let labelBottomInset: CGFloat = -15
        static let headerBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    }
}
