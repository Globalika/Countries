//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UIViewController {
    private var countryInfo = [(String, String)]()
    private var country: CountriesQuery.Data.Country?

    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
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

    let startHeader: CountriesHeaderView = {
        let header = CountriesHeaderView()
        return header
    }()

    init() { super.init(nibName: nil, bundle: nil) }

    init (country: CountriesQuery.Data.Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        fillDetailsViewWithData()
        configureStackView()
        title = "\(country?.name ?? Constants.detailsDefaultHeader)"
    }

    func fillDetailsViewWithData() {
        if let country = self.country {
            flagImageView.image = UIImage(named: country.code.lowercased())
            countryInfo.append(("\(Constants.countryNameDescription)",
                                "\(country.name)"))
            countryInfo.append(("\(Constants.countryCapitalDescription)",
                                "\(country.capital ?? Constants.notApplicableField)"))
            countryInfo.append(("\(Constants.countryContinentDescription)",
                                "\(country.continent.name)"))
            countryInfo.append(("\(Constants.countryCurrencyDescription)",
                                "\(country.currency ?? Constants.notApplicableField)"))
            let languages = country.languages.reduce("") {
                "\($0 + (((country.languages.count == 1) || ($0 == "")) ? "" : ", ") + ($1.name ?? ""))"
            }
            if country.languages.isEmpty {
                countryInfo.append(("\(Constants.countryLanguageDescription)", "\(Constants.notApplicableField)"))
            } else if country.languages.count == 1 {
                countryInfo.append(("\(Constants.countryLanguageDescription)", "\(languages)" ))
            } else {
                countryInfo.append(("\(Constants.countryLanguagesDescription)", "\(languages)" ))
            }
            countryInfo.append(("Calling Code:", "\(country.phone)"))
        }
    }

    func configureFlagImage() {
        view.addSubview(flagImageView)
        setFlagImageViewConstrains()
    }

    func configureStackView() {
        view.addSubview(header)
        setHeaderConstraints()
        configureFlagImage()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        addLabelsToStackView()
        setStackViewConstrains()
    }

    func setHeaderConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: Constants.headerTopInset),
            header.leftAnchor.constraint(equalTo: view.leftAnchor),
            header.rightAnchor.constraint(equalTo: view.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }

    func addLabelsToStackView() {
        var scenery: Scenery = .greenCircle
        for text in countryInfo {
            let placeHolder = DetailsFieldPlaceHolder()
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

    func setStackViewConstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor,
                                       constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -30).isActive = true
    }

    func setFlagImageViewConstrains() {
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                               constant: Constants.flagInset.top),
            flagImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: Constants.flagInset.left),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagHeight)
        ])
    }

    private struct Constants {
        static let notApplicableField = "N-A"
        static let detailsDefaultHeader = "Details"
        static let headerTopInset: CGFloat = 25
        static let headerHeight: CGFloat = 180
        static let stackSpacing: CGFloat = -12
        static let countryNameDescription = "Country:"
        static let countryCapitalDescription = "Capital:"
        static let countryContinentDescription = "Continent:"
        static let countryCurrencyDescription = "Currency:"
        static let countryLanguagesDescription = "Official Languages:"
        static let countryLanguageDescription = "Official Language:"
        static let countryCallingCodeDescription = "Calling Code:"
        static let curveLineImage = UIImage(named: "curveLine")
        static let labelDescriptionFontSize: CGFloat = 15
        static let labelDescriptionFontWeight: UIFont.Weight = .thin
        static let labelDataFontSize: CGFloat = 20
        static let labelDataFontWeight: UIFont.Weight = .bold
        static let flagInset = UIEdgeInsets(top: 3, left: 25, bottom: 0, right: 0)
        static let flagWidth: CGFloat = 100
        static let flagHeight: CGFloat = 80
    }
}

enum Scenery: String {
    case greenCircle, redCircle
    func cicleScenery() -> Scenery {
        switch self {
        case.greenCircle:
            return .redCircle
        case.redCircle:
            return .greenCircle
        }
    }
}
