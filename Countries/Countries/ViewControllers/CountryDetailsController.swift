//
//  CountryDetailsController.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import UIKit

class CountryDetailsController: UITableViewController {
    let countryCellId = "CountryDetailsCell"
    let languagesCellId = "LanguagesCell"
    private let country: CountriesQuery.Data.Country

    init (country: CountriesQuery.Data.Country) {
        self.country = country
        super.init(style: .plain)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    init?(country: CountriesQuery.Data.Country, coder: NSCoder) {
//        self.country = country
//
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: countryCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: languagesCellId)
        title = country.name
    }
}

extension CountryDetailsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0 {
          return 3
      }
      return country.languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: countryCellId, for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Code"
                cell.detailTextLabel?.text = "\(country.code)"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Capital"
                cell.detailTextLabel?.text = "\(String(describing: country.capital))"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Continent"
                cell.detailTextLabel?.text = "\(country.continent.name)"
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: languagesCellId, for: indexPath)

        cell.textLabel?.text = country.languages[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return section == 0 ? "Country Info" : "Languages"
    }
}
