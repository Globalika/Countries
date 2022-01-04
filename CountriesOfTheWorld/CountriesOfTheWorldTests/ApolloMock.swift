//
//  ApolloMock.swift
//  CountriesOfTheWorldTests
//
//  Created by Volodymyr Seredovych on 30.12.2021.
//

import Foundation
@testable import CountriesOfTheWorld

class ApolloMock: ApolloClientProtocol {
    func getCountries(completion: @escaping (Result<[CountryLite], Error>) -> Void) {
        let countries: [CountryLite] = [countryLite, countryLite, countryLite, countryLite]
        completion(Result.success(countries))
    }

    func getCountry(code: String, completion: @escaping (Result<CountryDetailed, Error>) -> Void) {
        completion(Result.success(countryDetails))
    }
    let countryLite = CountryLite(code: "UA",
                          name: "Ukraine",
                          capital: "Kyiv",
                          continent: ContinentModel(name: "Europe"))
    let countryDetails = CountryDetailed(code: "UA",
                                        name: "Ukraine",
                                        capital: "Kyiv",
                                        continent: ContinentModel(name: "Europe"),
                                        phone: "380",
                                        currency: "UAH",
                                        languages: [LanguageModel(name: "Ukrainian")])
}
