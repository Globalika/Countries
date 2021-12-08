//
//  CellDecoratorView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 03.12.2021.
//

import GradientView
import Foundation
import UIKit

class CellDecoratorView: UIView {
    var shadowView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var gradientView: GradientView = {
        var view = GradientView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var shadowOpacity: Float = Constants.defaultShadowOpacity {
        didSet {
           shadowView.layer.shadowOpacity = shadowOpacity
        }
    }

    var shadowRadius: CGFloat = Constants.defaultShadowRadius {
        didSet {
            shadowView.layer.shadowRadius = shadowRadius
        }
    }

    var shadowColor: UIColor? {
        didSet {
            shadowView.layer.shadowColor = shadowColor?.cgColor
        }
    }

    var shadowOffset: CGSize = .zero {
        didSet {
            shadowView.layer.shadowOffset = shadowOffset
        }
    }

    var cornerRadius: CGFloat = Constants.defaultCornerRadius {
        didSet {
            gradientView.layer.cornerRadius = cornerRadius
            shadowView.layer.cornerRadius = cornerRadius
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        confgiureDecoratorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func confgiureDecoratorView() {
        backgroundColor = .clear
        addSubview(shadowView)
        setShadowViewConstraints()
        addSubview(gradientView)
        setGradientViewConstraints()
        configureGradientView()
    }

    func configureGradientView() {
        gradientView.frame = self.bounds
        gradientView.direction = .vertical
        gradientView.colors = [Constants.cellGradientFirstColor,
                               Constants.cellGradientSecondColor]
        gradientView.locations = [Constants.firstColorGradientStopLocation,
                                  Constants.secondColorGradientStopLocation]
    }

    func setShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.leftAnchor.constraint(equalTo: self.leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: self.rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            shadowView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

    func setGradientViewConstraints() {
        NSLayoutConstraint.activate([
            gradientView.leftAnchor.constraint(equalTo: self.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: self.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradientView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

    private struct Constants {
        static let defaultShadowOpacity: Float = 0.0
        static let defaultShadowRadius: CGFloat = 0.0
        static let defaultCornerRadius: CGFloat = 0.0
        static let firstColorGradientStopLocation = 0.2188
        static let secondColorGradientStopLocation = 1.0
        static let cellGradientFirstColor = UIColor(rgb: 0xFFE485)
        static let cellGradientSecondColor = UIColor(rgb: 0xBA7B00)
    }
}
