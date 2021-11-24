//
//  CountriesController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountriesController: UITableViewController {
    let cellId = "cellId"
    var countries = [CountriesQuery.Data.Country]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        loadData()
    }
}

extension CountriesController {
    func loadData() {
        let query = CountriesQuery()
        
        Apollo.shared.client.fetch(query: query) { result in
            guard let countries = try? result.get().data?.countries else { return }
            self.countries = countries
        }
    }
}

extension CountriesController {
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let country = self.countries[indexPath.row]
        
        cell.textLabel?.text = country.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Countries"
    }
    
}
