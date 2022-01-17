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
    public let continent: ContinentModel
    public let phone: String
    public let currency: String?
    public let languages: [LanguageModel]

    init(code: String,
         name: String,
         capital: String?,
         continent: ContinentModel,
         phone: String,
         currency: String?,
         languages: [LanguageModel]) {
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
        guard let continent = ContinentModel(continent: continentGraphQL) else { return nil }
        let languages = languagesGraphQL.compactMap({ LanguageModel(language: $0) })
        self.init(code: code,
                  name: name,
                  capital: country?.capital,
                  continent: continent,
                  phone: phone,
                  currency: country?.currency,
                  languages: languages)
    }
}

extension CountryDetailed: Equatable {
    static func == (lhs: CountryDetailed, rhs: CountryDetailed) -> Bool {
        return lhs.code == rhs.code &&
               lhs.name == rhs.name &&
               lhs.capital == rhs.capital &&
               lhs.continent == rhs.continent &&
               lhs.phone == rhs.phone &&
               lhs.currency == rhs.currency &&
               lhs.languages == rhs.languages
    }
}
