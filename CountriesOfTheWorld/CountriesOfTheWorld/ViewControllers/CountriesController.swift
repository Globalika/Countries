//
//  CountriesController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountriesController: UITableViewController {
    var images: [UIImage] = []
    var countries = [CountriesQuery.Data.Country]() {
        didSet {
            loadImages()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CountryViewCell.self, forCellReuseIdentifier: CountryViewCell.identifier)
        loadData()
        title = "Countries"
    }
}

extension CountriesController {
    func loadData() {
        let query = CountriesQuery()

        Apollo.shared.client?.fetch(query: query) { result in
            guard let countries = try? result.get().data?.countries else { return }
            self.countries = countries
        }
    }
    func loadImages() {
        let _: [String] = countries.map({ $0.code.lowercased() })
    }
}

extension CountriesController {
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryViewCell.identifier,
                                                        for: indexPath) as? CountryViewCell else
                                                        { return UITableViewCell() }
        let country = self.countries[indexPath.row]
        if let image = UIImage(named: "\(country.code.lowercased())") {
            cell.flagImage = image
        }
        cell.countryNameView.text = country.name
        cell.countryCapitalView.text = country.capital ?? "N-A"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Countries"
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CountryDetailsController(country: countries[indexPath.row]),
                                                 animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    private struct Constants {
        static let rowHeight: CGFloat = 100
    }
}
