//
//  coverage.swift
//
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Foundation

public struct Coverage: SMModel {
    public let predictions: Bool
    public let topscorerGoals: Bool
    public let topscorerAssists: Bool
    public let topscorerCards: Bool

    enum CodingKeys: String, CodingKey {
        case predictions
        case topscorerGoals = "topscorer_goals"
        case topscorerAssists = "topscorer_assists"
        case topscorerCards = "topscorer_cards"
    }
}
