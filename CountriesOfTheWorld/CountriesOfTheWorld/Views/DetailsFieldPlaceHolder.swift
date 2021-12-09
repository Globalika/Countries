//
//  DetailsFieldPlaceHolder.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 09.12.2021.
//

import Foundation
import UIKit

class PlaceHolderView: UIView {
    var verticalStack: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    var circleImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var curveLineImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var tLable: UILabel = {
        var label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = Constants.labelAllowedLines
        label.minimumScaleFactor = Constants.labelMinimumScaleFactor
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private struct Constants {
        static let labelAllowedLines = 3
        static let labelMinimumScaleFactor: CGFloat = 0.5
    }
}
