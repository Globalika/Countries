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

    func setVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.widthAnchor.constraint(equalToConstant: Constants.verticalStackWidth)
        ])
    }

    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            tLable.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: Constants.labelTopInset),
            tLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tLable.leadingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            tLable.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    func setCircleImageConstraints() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: Constants.circleWidth),
            circleImageView.heightAnchor.constraint(equalToConstant: Constants.circleHeight)
        ])
    }

    func setCurveLineImageConstraints() {
        NSLayoutConstraint.activate([
            curveLineImageView.topAnchor.constraint(equalTo: circleImageView.bottomAnchor,
                                                    constant: Constants.curveLineTopInset),
            curveLineImageView.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            curveLineImageView.widthAnchor.constraint(equalToConstant: Constants.curveLineWidth),
            curveLineImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private struct Constants {
        static let labelAllowedLines = 3
        static let labelMinimumScaleFactor: CGFloat = 0.5
        static let verticalStackWidth: CGFloat = 80
        static let labelTopInset: CGFloat = 10
        static let labelHeight: CGFloat = 35
        static let circleWidth: CGFloat = 50
        static let circleHeight: CGFloat = 50
        static let curveLineTopInset: CGFloat = -10
        static let curveLineWidth: CGFloat = 50
    }
}
