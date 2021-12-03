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
    var shadowView: UIView = UIView()
    var gradientView: GradientView = GradientView()

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

    private struct Constants {
        static let defaultShadowOpacity: Float = 0.0
        static let defaultShadowRadius: CGFloat = 0.0
        static let defaultCornerRadius: CGFloat = 0.0
    }
}
