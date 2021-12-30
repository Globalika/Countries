//
//  ApolloMock.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 30.12.2021.
//

import Foundation
@testable import CountriesOfTheWorld

class ApolloMock: ApolloClientProtocol {
    func getCountries(completion: @escaping (Result<[CountriesQuery.Data.Country], Error>) -> Void) {
        let countries: [CountryLite] = [countryLite, countryLite, countryLite, countryLite]
        completion(Result.success(countries))
    }

    func getCountry(code: String, completion: @escaping (Result<CountryQuery.Data.Country, Error>) -> Void) {
        completion(Result.success(countryDetails))
    }
    typealias CountryLite = CountriesQuery.Data.Country
    typealias CountryDetails = CountryQuery.Data.Country
    let countryLite = CountryLite(code: "UA",
                          name: "Ukraine",
                          capital: "Kyiv",
                          continent: CountryLite.Continent(name: "Europe"))
    let countryDetails = CountryDetails(code: "UA",
                                        name: "Ukraine",
                                        capital: "Kyiv",
                                        continent: CountryDetails.Continent(name: "Europe"),
                                        phone: "380",
                                        currency: "UAH",
                                        languages: [CountryDetails.Language(name: "Ukrainian")])
}
