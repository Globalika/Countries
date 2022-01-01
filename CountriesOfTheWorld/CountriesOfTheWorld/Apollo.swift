//
//  Apollo.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Apollo
import Foundation

protocol ApolloClientProtocol {
    func getCountries(completion: @escaping (Result<[CountryLite], Error>) -> Void)
    func getCountry(code: String,
                    completion: @escaping (Result<CountryQuery.Data.Country, Error>) -> Void)
}

class Apollo: ApolloClientProtocol {
    func getCountries(completion: @escaping (Result<[CountryLite], Error>) -> Void) {
        let query = CountriesQuery()
        apollo?.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(Result.success(data.countries.compactMap({ CountryLite(country: $0) })))
                } else if let errors = graphQLResult.errors {
                    print(errors)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getCountry(code: String, completion: @escaping (Result<CountryQuery.Data.Country, Error>) -> Void) {
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
        guard let url = URL(string: "https://countries.trevorblades.com") else {
            print("error: invalid url")
            return nil
        }
        return ApolloClient(url: url)
    }()
}

class CountryLite {
    public let code: String
    public let name: String
    public let capital: String?
    public let continent: Continent
    
    init(code: String,
         name: String,
         capital: String?,
         continent: Continent) {
        self.code = code
        self.name = name
        self.capital = capital
        self.continent = continent
    }
    
    convenience init?(country: CountriesQuery.Data.Country?) {
        guard
            let code = country?.code,
            let name = country?.name,
            let capital = country?.capital,
            let continent = country?.continent
        else {
            return nil
        }
        self.init(code: code,
                  name: name,
                  capital: capital,
                  continent: Continent(name: continent.name))
    }
}

class Continent {
    public let name: String
    
    init(name: String) {
        self.name = name
    }
    convenience init?(country: Continent?) {
        guard let name = country?.name
        else {
            return nil
        }
        self.init(name: name)
    }
}

class Language {
    public let name: String
    
    init(name: String) {
        self.name = name
    }
    convenience init?(country: Language?) {
        guard let name = country?.name
        else {
            return nil
        }
        self.init(name: name)
    }
}
