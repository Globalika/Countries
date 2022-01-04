//
//  CountryDetailed.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

typealias CountryDetailedGraphQL = CountryQuery.Data.Country

class CountryDetailed {
    public let code: String
    public let name: String
    public let capital: String?
    public let continent: Continent
    public let phone: String
    public let currency: String?
    public let languages: [Language]

    init(code: String,
         name: String,
         capital: String?,
         continent: Continent,
         phone: String,
         currency: String?,
         languages: [Language]) {
        self.code = code
        self.name = name
        self.capital = capital
        self.continent = continent
        self.phone = phone
        self.currency = currency
        self.languages = languages
    }

    convenience init?(country: CountryDetailedGraphQL?) {
        guard
            let code = country?.code,
            let name = country?.name,
            let continentGraphQL = country?.continent,
            let phone = country?.phone,
            let languagesGraphQL = country?.languages
        else {
            return nil
        }
        guard let continent = Continent(continent: continentGraphQL) else { return nil }
        let languages = languagesGraphQL.compactMap({ Language(language: $0) })
        self.init(code: code,
                  name: name,
                  capital: country?.capital,
                  continent: continent,
                  phone: phone,
                  currency: country?.currency,
                  languages: languages)
    }
}
