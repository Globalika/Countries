//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UIViewController {
    var networkManager: NetworkManager
    var currentDevice: Device

    private var countryInfo = [(String, String)]()
    private var country: CountryQuery.Data.Country? {
        didSet {
            configureAllViews()
        }
    }
    var countryBasic: CountriesQuery.Data.Country?

    let startHeader: CountriesHeaderView = {
        let header = CountriesHeaderView()
        return header
    }()

    lazy var contentView: DetailsContentForIPhoneView = {
        let view = DetailsContentForIPhoneView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(_ currentDevice: Device,
         _ networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.currentDevice = currentDevice
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureStartHeader()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAllViews()
        configureRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let countryCode = countryBasic?.code else { return }
        loadData(code: countryCode)
    }

    func loadData(code: String) {
        networkManager.client.getCountry(code: code) { result in
            guard let country = try? result.get() else { return }
            self.country = country
        }
    }

    func configureStartHeader() {
        startHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        startHeader.imageView.heightAnchor.constraint(equalToConstant:
                                                        Constants.imageHeight).isActive = true
        startHeader.headerLabel.font = .systemFont(ofSize: Constants.headerLabelFontSize)
    }

    private func configureAllViews() {
        country != nil ? fillDetailsViewWithCountryQuery() : fillDetailsViewWithData()
        if currentDevice == .iPad {
            if !countryInfo.isEmpty {
                if startHeader.isDescendant(of: view) {
                    startHeader.removeFromSuperview()
                }
                configureContentView()
            } else {
                view.addSubview(startHeader)
            }
        } else {
            configureContentView()
        }
    }

    private func configureRefreshControl() {
        contentView.refreshControl.addTarget(self,
                                             action: #selector(refresh(sender:)),
                                             for: .valueChanged)
    }

    @objc private func refresh(sender: UIRefreshControl) {
        guard let countryCode = country?.code else { return }

        loadData(code: countryCode)
        configureAllViews()
        sender.endRefreshing()
    }

    func configureContentView() {
        navigationItem.title = "Country List"
        view.backgroundColor = .white
        view.addSubview(contentView)
        setContentViewConstraints()
    }

    func fillDetailsViewWithData() {
        guard let countryBasic = countryBasic else { return }
        countryInfo.append(("\(Constants.countryNameDescription)",
                            "\(String(describing: countryBasic.name))"))
        countryInfo.append(("\(Constants.countryCapitalDescription)",
                            "\(countryBasic.capital ?? Constants.notApplicableField)"))
        countryInfo.append(("\(Constants.countryContinentDescription)",
                            "\(String(describing: countryBasic.continent.name))"))
        contentView.flagImageView.image = UIImage(named: countryBasic.code.lowercased())
        contentView.countryInfo = self.countryInfo
    }

    func fillDetailsViewWithCountryQuery() {
        guard let country = self.country else { return }
        countryInfo.removeAll()
        contentView.stackView.removeAllSubviews()
        countryInfo.append(("\(Constants.countryNameDescription)",
                            "\(String(describing: country.name))"))
        countryInfo.append(("\(Constants.countryCapitalDescription)",
                            "\(country.capital ?? Constants.notApplicableField)"))
        countryInfo.append(("\(Constants.countryContinentDescription)",
                            "\(String(describing: country.continent.name))"))
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
        contentView.flagImageView.image = UIImage(named: country.code.lowercased())
        contentView.countryInfo = self.countryInfo
    }

    func setContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: Constants.contentTopInset),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private struct Constants {
        static let notApplicableField = "N-A"
        static let detailsDefaultHeader = "Details"
        static let contentTopInset: CGFloat = 25
        static let imageHeight: CGFloat = 180
        static let countryNameDescription = "Country:"
        static let countryCapitalDescription = "Capital:"
        static let countryContinentDescription = "Continent:"
        static let countryCurrencyDescription = "Currency:"
        static let countryLanguagesDescription = "Official Languages:"
        static let countryLanguageDescription = "Official Language:"
        static let countryCallingCodeDescription = "Calling Code:"
        static let headerLabelFontSize: CGFloat = 80
    }
}

enum Scenery {
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
