//
//  CountriesController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountriesController: UITableViewController {
    var networkManager: NetworkManager
    

    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()

    var images: [UIImage] = []
    var countries = [CountryLite]() {
        didSet {
            tableView.reloadData()
        }
    }

    var filteredCountries: [CountryLite]?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        setupSearchBar()
    }

    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    func configureTableView() {
        tableView.register(CountryViewCell.self,
                           forCellReuseIdentifier: CountryViewCell.identifier)
        tableView.register(CountriesHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: CountriesHeaderView.identifier)
        tableView.separatorStyle = .none

        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = Constants.navigationBarTitle
        navigationItem.backButtonTitle = ""
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = Constants.tableViewPadding
        }
    }
}

extension CountriesController {

    func loadData() {
        networkManager.client.getCountries { result in
            guard let countries = try? result.get() else { return }
            self.countries = countries
        }
    }
}

extension CountriesController {
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryViewCell.identifier,
                                                       for: indexPath) as? CountryViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.updateCell(country: filteredCountries?[indexPath.row] ?? countries[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries?.count ?? countries.count
    }

    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        if UIDevice.current.userInterfaceIdiom == .phone {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CountriesHeaderView.identifier)
                    as? CountriesHeaderView else { return UITableViewHeaderFooterView() }
            header.imageView.heightAnchor.constraint(equalToConstant:
                                                        Constants.imageViewHeight).isActive = true
            header.headerLabel.font = .systemFont(ofSize: Constants.headerLabelHeight)
            return header
        } else {
            return UIView()
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (UIDevice.current.userInterfaceIdiom == .phone) ? Constants.headerHeight : 0
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let detailsController = CountryDetailsController(networkManager)
        detailsController.countryBasic = filteredCountries?[indexPath.row] ?? countries[indexPath.row]
        showDetailViewController(UINavigationController(rootViewController: detailsController),
                                 sender: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    private struct Constants {
        static let rowHeight: CGFloat = 185
        static let headerHeight: CGFloat = 160
        static let navigationBarTitle = "Country List"
        static let tableViewPadding: CGFloat = 0
        static let headerLabelHeight: CGFloat = 30
        static let imageViewHeight: CGFloat = 110
        static let notApplicableField = "N-A"
    }
}

extension CountriesController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCountries = countries.filter({ country in
            country.name.lowercased().contains(searchText.lowercased()) ||
            (country.capital ?? Constants.notApplicableField).lowercased().contains(searchText.lowercased()) ||
            country.continent.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCountries = nil
        tableView.reloadData()
    }
}
