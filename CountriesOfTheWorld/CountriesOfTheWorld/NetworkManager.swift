//
//  NetworkManager.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 30.12.2021.
//

import Foundation

class NetworkManager {
    var client: ApolloClientProtocol
    init(client: ApolloClientProtocol) {
        self.client = client
    }
}
