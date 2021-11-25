//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController2: UIViewController {
    private var countryInfo: [String: String] = [:]
    private let country: CountriesQuery.Data.Country
    init (country: CountriesQuery.Data.Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    var stackView = UIStackView()
    var flagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var countryDetailsViews: [UILabel] = {
        var labelViews = [UILabel()]
        for labelView in labelViews {
            labelView.translatesAutoresizingMaskIntoConstraints = false
        }
        return labelViews
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        countryInfo["Name: "] = country.name
        if let capital = country.capital {
            countryInfo["Capital: "] = capital
        } else {
            countryInfo["Capital: "] = "N-A"
        }
        countryInfo["Continent: "] = country.continent.name
        countryInfo["Phone: "] = country.phone
        if let currency = country.currency {
            countryInfo["Capital: "] = currency
        } else {
            countryInfo["Capital: "] = "N-A"
        }
        for (language, index) in zip(country.languages, 0..<country.languages.count) {
            countryInfo["Language\(index): "] = language.name!
        }
        
        view.backgroundColor = .lightGray
        flagImageView.image = UIImage(named: "\(country.code.lowercased())")
        configureFlagImage()
        configureStackView()
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
            label.text = "\(text.key) \(text.value)"
            stackView.addArrangedSubview(label)
        }
    }
    
    
    func configureFlagImage() {
        view.addSubview(flagImageView)
        setFlagImageViewConstrains()
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
    
}
