//
//  Language.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

class LanguageModel: Equatable {
    static func == (lhs: LanguageModel, rhs: LanguageModel) -> Bool {
        return lhs.name == rhs.name
    }

    public let name: String?

    init(name: String?) {
        self.name = name
    }
    convenience init?(language: CountryDetailedGraphQL.Language?) {
        guard let name = language?.name
        else {
            return nil
        }
        self.init(name: name)
    }
}
