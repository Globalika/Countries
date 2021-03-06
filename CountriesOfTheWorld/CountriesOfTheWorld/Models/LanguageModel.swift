//
//  Language.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 04.01.2022.
//

import Foundation

class LanguageModel {
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

extension LanguageModel: Equatable {
    static func == (lhs: LanguageModel, rhs: LanguageModel) -> Bool {
        return lhs.name == rhs.name
    }
}
