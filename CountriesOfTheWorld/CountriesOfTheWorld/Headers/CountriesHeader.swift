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

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a card :)"
        label.font = .systemFont(ofSize: Constants.headerLabelFont)
        label.textAlignment = .center
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    private struct Constants {
        static let headerLabelFont: CGFloat = 25
    }
}
