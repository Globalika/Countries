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

    var gradientColors: [UIColor] = [UIColor.white] {
        didSet {
            var colors: [UIColor] = []
            for color in gradientColors {
                colors.append(color)
            }
            gradientView.colors = colors
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        confgiureDecoratorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        confgiureDecoratorView()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientView.frame = self.bounds
        gradientView.direction = .vertical
        gradientView.locations = [Constants.firstColorGradientStopLocation,
                                  Constants.secondColorGradientStopLocation]
    }

    func confgiureDecoratorView() {
        addSubview(shadowView)
        setShadowVIewConstraints()
        addSubview(gradientView)
        setGradientViewConstraints()
        sendSubviewToBack(gradientView)
        sendSubviewToBack(shadowView)
        backgroundColor = .clear
    }

    func setShadowVIewConstraints() {
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
    }
}
