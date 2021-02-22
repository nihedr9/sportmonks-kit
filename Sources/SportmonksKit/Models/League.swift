//
//  League.swift
//  
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Foundation

public struct League: SMModel {
    public let id: Int
    public let legacyId: Int?
    public let countryId: Int
    public let currentSeasonId: Int?
    public let currentRoundId: Int?
    public let currentStageId: Int?

    public let active: Bool
    public let isCup: Bool
    public let liveStandings: Bool

    public let logoPath: String
    public let name: String

    public let coverage: Coverage

    enum CodingKeys: String, CodingKey {
        case id
        case legacyId = "legacy_id"
        case countryId = "country_id"
        case currentSeasonId = "current_season_id"
        case currentRoundId = "current_round_id"
        case currentStageId = "current_stage_id"

        case active
        case isCup = "is_cup"
        case liveStandings = "live_standings"

        case logoPath = "logo_path"
        case name

        case coverage
    }
}
