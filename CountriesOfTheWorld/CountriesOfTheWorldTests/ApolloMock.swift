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
        let countries: [CountryLite] = [countryCanadaLite,
                                        countryIvoryCoastLite,
                                        countryCanadaLite,
                                        countryUkraineLite]
        completion(Result.success(countries))
    }

    func getCountry(code: String, completion: @escaping (Result<CountryDetailed, Error>) -> Void) {
        completion(Result.success(countryDetails))
    }
    let countryUkraineLite = CountryLite(code: "CI",
                                         name: "Ivory Coast",
                                         capital: "Yamoussoukro",
                                         continent: ContinentModel(name: "Africa"))
    let countryIvoryCoastLite = CountryLite(code: "UA",
                                            name: "Ukraine",
                                            capital: "Kyiv",
                                            continent: ContinentModel(name: "Europe"))
    let countryCanadaLite = CountryLite(code: "CA",
                                        name: "Canada",
                                        capital: "Ottawa",
                                        continent: ContinentModel(name: "North America"))
    let countryDetails = CountryDetailed(code: "UA",
                                        name: "Ukraine",
                                        capital: "Kyiv",
                                        continent: ContinentModel(name: "Europe"),
                                        phone: "380",
                                        currency: "UAH",
                                        languages: [LanguageModel(name: "Ukrainian")])
}
