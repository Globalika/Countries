//
//  CountriesController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountriesController: UITableViewController {
    let cellId = "cellId"
    var countries: [CountriesQuery.Data.Country] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
