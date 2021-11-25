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

    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .blue
        switcher.isOn = true
        return switcher
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(switcher)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        switcher.frame = CGRect(x: 5,
                                y: 5,
                                width: 100,
                                height: contentView.frame.size.height-10)
    }
}
