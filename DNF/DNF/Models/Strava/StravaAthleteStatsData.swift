//
//  StravaAthleteStatsData.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

struct StravaAthleteStatsData: Codable {
    let recentRunTotals: StravaStatTotals?
    let ytdRunTotals: StravaStatTotals?
    let allRunTotals: StravaStatTotals?

    enum CodingKeys: String, CodingKey {
        case recentRunTotals = "recent_run_totals"
        case ytdRunTotals = "ytd_run_totals"
        case allRunTotals = "all_run_totals"
    }
}

struct StravaStatTotals: Codable {
    
    let count: Int
    
    // To be processed, raw values
    let _distance: Double
    let _elapsedTime: Int
    let _elevationGain: Int
    
    // Public computed variables
    
    /// The distance ran, in miles
    public var distance: Double {
        _distance.metersToMilesValue
    }
    /// The distance ran, in miles in UI format
    public var distanceUI: String {
        _distance.metersToMilesStringValue
    }
    /// The elapsed time, neatly formatted
    public var elapsedTime: String {
        _elapsedTime.hhmmssStringValue
    }
    /// The elevation gain, in feet
    public var elevationGain: Int {
        _elevationGain.metersToFeetValue
    }
    

    enum CodingKeys: String, CodingKey {
        case _distance = "distance"
        case _elapsedTime = "elapsed_time"
        case _elevationGain = "elevation_gain"
        case count
    }
}
