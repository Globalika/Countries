//
//  DetailsContentForIPhoneView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 20.12.2021.
//

import Foundation
import UIKit

class DetailsContentForIPhoneView {
    var header: CountriesDetailsHeader = {
        var header = CountriesDetailsHeader()
        header.contentMode = .scaleAspectFit
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    var stackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fillEqually
        return stack
    }()

    private struct Constants {
        static let stackSpacing: CGFloat = 5
    }
}
