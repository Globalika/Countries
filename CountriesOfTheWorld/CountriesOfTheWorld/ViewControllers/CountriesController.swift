//
//  CountriesController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountriesController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var images: [UIImage] = []
    var countries = [CountriesQuery.Data.Country]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
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
        tableView.bounces = false
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

    func loadData(searchText: String) {
        let query = CountriesQuery()

        Apollo.shared.client?.fetch(query: query) { result in

            guard let countries = try? result.get().data?.countries else { return }
            self.countries = countries.filter({ country in
                country.name.lowercased().contains(searchText.lowercased()) ||
                (country.capital ?? "N/A").lowercased().contains(searchText.lowercased()) ||
                country.continent.name.lowercased().contains(searchText.lowercased())
            })
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
        cell.updateCell(country: countries[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let cell = tableView.cellForRow(at: indexPath) as? CountryViewCell {
                cell.didSelect(indexPath: indexPath)
            }
        }

        let detailsController = CountryDetailsController()
        detailsController.countryBasic = countries[indexPath.row]
        showDetailViewController(UINavigationController(rootViewController: detailsController),
                                 sender: nil)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CountryViewCell {
            cell.didDeselect(indexPath: indexPath)
        }
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
    }
}

extension CountriesController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(searchText: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.search = nil
//        self.table?.reloadData()
    }
}
