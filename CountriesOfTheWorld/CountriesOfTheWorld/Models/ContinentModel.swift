//
//  Continent.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

class ContinentModel {
    public let name: String

    init(name: String) {
        self.name = name
    }
    convenience init?(continent: CountryLiteGraphQL.Continent?) {
        guard let name = continent?.name
        else {
            return nil
        }
        self.init(name: name)
    }
    convenience init?(continent: CountryDetailedGraphQL.Continent?) {
        guard let name = continent?.name
        else {
            return nil
        }
        self.init(name: name)
    }
}
