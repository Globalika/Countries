//
//  Apollo.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 24.11.2021.
//

import Foundation
import Apollo

class Apollo {
    // 1
    static let shared = Apollo()
    // 2
    let client: ApolloClient
    // 3
    init() {
      client = ApolloClient(url: URL(string: "https://countries.trevorblades.com")!)
    }
}
