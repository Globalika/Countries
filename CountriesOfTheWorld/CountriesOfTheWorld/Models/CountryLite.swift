//
//  CountryLite.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

typealias CountryLiteGraphQL = CountriesQuery.Data.Country

class CountryLite {
    public let code: String
    public let name: String
    public let capital: String?
    public let continent: ContinentModel

    init(code: String,
         name: String,
         capital: String?,
         continent: ContinentModel) {
        self.code = code
        self.name = name
        self.capital = capital
        self.continent = continent
    }

    convenience init?(country: CountryLiteGraphQL?) {
        guard
            let code = country?.code,
            let name = country?.name,
            let continentGraphQL = country?.continent
        else {
            return nil
        }
        guard let continent = ContinentModel(continent: continentGraphQL) else { return nil }
        self.init(code: code,
                  name: name,
                  capital: country?.capital,
                  continent: continent)
    }
}

extension CountryLite: Equatable {
    static func == (lhs: CountryLite, rhs: CountryLite) -> Bool {
        return lhs.code == rhs.code &&
               lhs.name == rhs.name &&
               lhs.capital == rhs.capital &&
               lhs.continent == rhs.continent
    }
}
