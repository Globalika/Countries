//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UIViewController {
    var networkManager: NetworkManager

    private var countryInfo = [(String, String)]()
    private var country: CountryDetailed? {
        didSet {
            configureAllViews()
        }
    }
    var countryBasic: CountryLite?

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

    let startHeader: CountriesHeaderView = {
        let header = CountriesHeaderView()
        return header
    }()

    lazy var refrechControl: UIRefreshControl = {
        let refrechControl = UIRefreshControl()
        refrechControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refrechControl
    }()

    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        startHeader.imageView.heightAnchor.constraint(equalToConstant:
                                                        Constants.headerHeight).isActive = true
        startHeader.headerLabel.font = .systemFont(ofSize: Constants.headerLabelFontSize)
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
        configureRefreshControl()
        configureAllViews()
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

    private func configureAllViews() {
        country != nil ? fillDetailsViewWithCountryQuery() : fillDetailsViewWithData()
        if UIDevice.current.userInterfaceIdiom == .pad {
            if !countryInfo.isEmpty {
                if startHeader.isDescendant(of: view) {
                    startHeader.removeFromSuperview()
                }
                configureDetailsView()
            } else {
                view.addSubview(startHeader)
            }
        } else {
            configureDetailsView()
        }
    }

    private func configureRefreshControl() {
        scrollView.refreshControl = refrechControl
    }

    @objc private func refresh(sender: UIRefreshControl) {
        guard let countryCode = country?.code else { return }

        loadData(code: countryCode)
        configureAllViews()
        sender.endRefreshing()
    }

    func configureDetailsView() {
        navigationItem.title = "Country List"
        view.backgroundColor = .white
        view.addSubview(header)
        setHeaderConstraints()
        view.addSubview(scrollView)
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

    func fillDetailsViewWithData() {
        guard let countryBasic = countryBasic else { return }
            flagImageView.image = UIImage(named: countryBasic.code.lowercased())
            countryInfo.append(("\(Constants.countryNameDescription)",
                                "\(String(describing: countryBasic.name))"))
            countryInfo.append(("\(Constants.countryCapitalDescription)",
                                "\(countryBasic.capital ?? Constants.notApplicableField)"))
            countryInfo.append(("\(Constants.countryContinentDescription)",
                                "\(String(describing: countryBasic.continent.name))"))
        }

    func fillDetailsViewWithCountryQuery() {
        guard let country = self.country else { return }
        countryInfo.removeAll()
        stackView.removeAllSubviews()
        flagImageView.image = UIImage(named: country.code.lowercased())
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
    }

    func setScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        static let flagInsets = UIEdgeInsets(top: 3, left: 25, bottom: 0, right: 0)
        static let stackInsets = UIEdgeInsets(top: 10, left: 5, bottom: -70, right: -30)
        static let flagWidth: CGFloat = 100
        static let flagHeight: CGFloat = 80
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
