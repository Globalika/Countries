//
//  Apollo.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Apollo
import Foundation

class Apollo {

    static let shared = Apollo()

    let client: ApolloClient?

    private init() {
        guard let url = URL(string: "https://countries.trevorblades.com") else {
            print("error: invalid url")
            client = nil
            return
        }
        client = ApolloClient(url: url)
    }
}
