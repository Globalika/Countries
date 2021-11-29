//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UIViewController {
    var stackView = UIStackView()
    private var countryInfo: [String: String] = [:]
    private let country: CountriesQuery.Data.Country

    init (country: CountriesQuery.Data.Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        fillDetailsViewWithData()
        configureFlagImage()
        configureStackView()
    }

    func fillDetailsViewWithData() {
        flagImageView.image = UIImage(named: "\(country.code.lowercased())")
        countryInfo["Name: "] = country.name
        countryInfo["Capital: "] = country.capital ?? Constants.notApplicableField
        countryInfo["Continent: "] = country.continent.name
        countryInfo["Phone: "] = country.phone
        countryInfo["Capital: "] = country.currency ?? Constants.notApplicableField
        for (index, language) in country.languages.enumerated() {
            countryInfo["Language\(index): "] = language.name!
        }
    }

    func configureFlagImage() {
        view.addSubview(flagImageView)
        setFlagImageViewConstrains()
    }

    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        addLabelsToStackView()
        setStackViewConstrains()
    }

    func addLabelsToStackView() {
        for text in countryInfo.sorted(by: { $0.key > $1.key }) {
            let label = UILabel()
            label.text = "\(text.key)\(text.value)"
            stackView.addArrangedSubview(label)
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
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 2).isActive = true
        flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 80).isActive = true
        flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -80).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    private struct Constants {
        static let notApplicableField: String = "N-A"
    }
}
