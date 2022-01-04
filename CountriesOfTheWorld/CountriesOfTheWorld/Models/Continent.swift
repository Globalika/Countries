//
//  Continent.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

class Continent {
    public let name: String

    init(name: String) {
        self.name = name
    }
    convenience init?(continent: CountryQuery.Data.Country.Continent?) {
        guard let name = continent?.name
        else {
            return nil
        }
        self.init(name: name)
    }
    convenience init?(continent: CountriesQuery.Data.Country.Continent?) {
        guard let name = continent?.name
        else {
            return nil
        }
        self.init(name: name)
    }
}
