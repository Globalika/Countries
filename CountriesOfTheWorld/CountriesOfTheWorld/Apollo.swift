//
//  Apollo.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Apollo
import Foundation

typealias CountryLite = CountriesQuery.Data.Country
typealias CountryDetailed = CountryQuery.Data.Country

protocol ApolloClientProtocol {
    func getCountries(completion: @escaping (Result<[CountryLite], Error>) -> Void)
    func getCountry(code: String,
                    completion: @escaping (Result<CountryDetailed, Error>) -> Void)
}

class Apollo: ApolloClientProtocol {
    private let apiUrl = URL(string: "https://countries.trevorblades.com")

    func getCountries(completion: @escaping (Result<[CountryLite], Error>) -> Void) {
        let query = CountriesQuery()
        apollo?.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(Result.success(data.countries))
                } else if let errors = graphQLResult.errors {
                    print(errors)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getCountry(code: String, completion: @escaping (Result<CountryDetailed, Error>) -> Void) {
        let query = CountryQuery(code: code)
        apollo?.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let country = graphQLResult.data?.country {
                    completion(Result.success(country))
                } else if let errors = graphQLResult.errors {
                    print(errors)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private(set) lazy var apollo: ApolloClient? = {
        guard let url = apiUrl else {
            print("error: invalid url")
            return nil
        }
        return ApolloClient(url: url)
    }()
}
