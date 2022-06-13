//
//  StravaAthleteStatsData.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

struct StravaAthleteStatsData: Codable {
    let recentRunTotals: StravaStatTotals
    let ytdRunTotals: StravaStatTotals
    let allRunTotals: StravaStatTotals

    enum CodingKeys: String, CodingKey {
        case recentRunTotals = "recent_run_totals"
        case ytdRunTotals = "ytd_run_totals"
        case allRunTotals = "all_run_totals"
    }
}

struct StravaStatTotals: Codable {
    let count, distance, movingTime, elapsedTime: Int
    let elevationGain, achievementCount: Int

    enum CodingKeys: String, CodingKey {
        case count, distance
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case elevationGain = "elevation_gain"
        case achievementCount = "achievement_count"
    }
}
