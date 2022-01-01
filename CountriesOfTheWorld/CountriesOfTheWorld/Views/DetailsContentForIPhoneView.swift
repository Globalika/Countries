//
//  DetailsContentForIPhoneView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 20.12.2021.
//

import Foundation
import UIKit

class DetailsContentForIPhoneView: UIView {
    public var countryInfo = [(String, String)]() {
        didSet {
            configureDetailsView()
        }
    }

    var refreshControl = UIRefreshControl()

    var header: UIView = {
        var header = UIDevice.current.userInterfaceIdiom == .phone ?
        CountriesDetailsHeaderForIPhone() : CountriesDetailsHeaderForIPad()
        //(header as? CountriesDetailsHeaderForIPad)?.flagsImageView.image = UIImage(named: "")
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailsView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureRefreshControl() {
        scrollView.refreshControl = refreshControl
    }

    func configureDetailsView() {
        addSubview(header)
        setHeaderConstraints()
        addSubview(scrollView)
        setScrollViewConstraints()
        configureScrollView()
    }

    func configureScrollView() {
        scrollView.addSubview(flagImageView)
        setFlagImageViewConstrains()
        configureStackView()
    }

    func configureStackView() {
        scrollView.addSubview(stackView)
        setStackViewConstrains()
        addLabelsToStackView()
    }

    func addLabelsToStackView() {
        var scenery: Scenery = .greenCircle
        for text in countryInfo {
            let placeHolder = DetailsFieldPlaceHolderView()
            placeHolder.circleImageView.image = UIImage(named: "\(scenery)")
            if text.0 != countryInfo.last?.0 {
                placeHolder.curveLineImageView.image = Constants.curveLineImage
            }
            placeHolder.fieldLabel.setAttributedText(descriptionText: text.0,
                                                     descriptionTextFont:
                                                            .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                                                        weight: Constants.labelDescriptionFontWeight),
                                                     dataText: text.1,
                                                     dataTextFont:
                                                            .systemFont(ofSize: Constants.labelDataFontSize,
                                                                        weight: Constants.labelDataFontWeight))
            stackView.addArrangedSubview(placeHolder)
            scenery = scenery.cicleScenery()
        }
    }

    func setScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setHeaderConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: Constants.headerTopInset),
            header.leftAnchor.constraint(equalTo: self.leftAnchor),
            header.rightAnchor.constraint(equalTo: self.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }

    func setStackViewConstrains() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor,
                                           constant: Constants.stackInsets.top),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Constants.stackInsets.left),
            stackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
                                                constant: Constants.stackInsets.right),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                              constant: Constants.stackInsets.bottom)
        ])
    }

    func setFlagImageViewConstrains() {
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                               constant: Constants.flagInsets.top),
            flagImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: Constants.flagInsets.left),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagHeight)
        ])
    }

    private struct Constants {
        static let headerTopInset: CGFloat = 20
        static let headerHeight: CGFloat = 160
        static let stackSpacing: CGFloat = -12
        static let flagInsets = UIEdgeInsets(top: 3, left: 25, bottom: 0, right: 0)
        static let stackInsets = UIEdgeInsets(top: 10, left: 5, bottom: -70, right: -30)
        static let flagWidth: CGFloat = 100
        static let flagHeight: CGFloat = 80
        static let curveLineImage = UIImage(named: "curveLine")
        static let labelDescriptionFontSize: CGFloat = 15
        static let labelDescriptionFontWeight: UIFont.Weight = .thin
        static let labelDataFontSize: CGFloat = 20
        static let labelDataFontWeight: UIFont.Weight = .bold
    }
}
