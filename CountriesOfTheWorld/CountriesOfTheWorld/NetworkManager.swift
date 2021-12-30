//
//  NetworkManager.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 29.12.2021.
//

import Foundation

class NetworkManager {
    var client: ApolloClientProtocol
    init(client: ApolloClientProtocol) {
        self.client = client
    }
}
