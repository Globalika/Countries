//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UIViewController {
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

    lazy var refrechControl: UIRefreshControl = {
        let refrechControl = UIRefreshControl()
        refrechControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refrechControl
    }()

    init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        startHeader.imageView.heightAnchor.constraint(equalToConstant:
                                                        Constants.imageHeight).isActive = true
        startHeader.headerLabel.font = .systemFont(ofSize: Constants.headerLabelFontSize)
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
        let query = CountryQuery(code: code)

        Apollo.shared.client?.fetch(query: query) { result in
            guard let country = try? result.get().data?.country else { return }
            self.country = country
        }
    }

    private func configureAllViews() {
        country != nil ? fillDetailsViewWithCountryQuery() : fillDetailsViewWithData()
        if UIDevice.current.userInterfaceIdiom == .pad {
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
        contentView.scrollView.refreshControl = refrechControl
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
        contentView.flagImageView.image = UIImage(named: countryBasic.code.lowercased())
        countryInfo.append(("\(Constants.countryNameDescription)",
                            "\(String(describing: countryBasic.name))"))
        countryInfo.append(("\(Constants.countryCapitalDescription)",
                            "\(countryBasic.capital ?? Constants.notApplicableField)"))
        countryInfo.append(("\(Constants.countryContinentDescription)",
                            "\(String(describing: countryBasic.continent.name))"))
        contentView.countryInfo = self.countryInfo
    }

    func fillDetailsViewWithCountryQuery() {
        guard let country = self.country else { return }
        countryInfo.removeAll()
        contentView.stackView.removeAllSubviews()
        contentView.flagImageView.image = UIImage(named: country.code.lowercased())
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
        static let headerImageHeight: CGFloat = 200
        static let headerLabelFontSize: CGFloat = 80
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
