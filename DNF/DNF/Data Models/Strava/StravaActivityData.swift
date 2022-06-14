//
//  StravaActivityData.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

struct StravaActivityData {
    /// All of the past 30 activities
    var allActivities: [StravaActivity]

    /// The most recent activity
    var featuredActivity: StravaActivity? {
        let filteredActivities = allActivities.filter { $0.sportType == StravaAPIConfiguration.mainActivityType }
        return filteredActivities.sorted(by: { $0.startDate > $1.startDate }).first
    }
    
}

// TODO clean this up / documentation
struct StravaActivity: Codable {
    let id: Int
    let name: String
    
    let totalElevationGain: Int
    let type, sportType: String
    let photoCount: Int
    let map: Map
    let startLatlng, endLatlng: [Double]
    let averageSpeed, maxSpeed, averageCadence, averageWatts: Double?
    let maxWatts, weightedAverageWatts: Int?
    let kilojoules: Double?
    let hasHeartrate: Bool
    let averageHeartrate: Double
    let maxHeartrate: Int
    let elevHigh, elevLow, uploadID: Int
    let uploadIDStr, externalID: String
    let prCount: Int
    
    // To be processed, raw values
    let _distance: Double
    let _elapsedTime: Int
    let _startDate: String
    
    // Public computed variables
    
    /// The distance ran, in miles
    public var distance: Double {
        _distance.metersToMilesValue
    }
    /// The elapsed time, neatly formatted
    public var elapsedTime: String {
        _elapsedTime.hhmmssStringValue
    }
    /// The date the activity took place
    public var startDate: Date {
        _startDate.isoDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
        case _distance = "distance"
        case _elapsedTime = "elapsed_time"
        case _startDate = "start_date"
        case totalElevationGain = "total_elevation_gain"
        case sportType = "sport_type"
        case photoCount = "photo_count"
        case map
        case startLatlng = "start_latlng"
        case endLatlng = "end_latlng"
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case averageCadence = "average_cadence"
        case averageWatts = "average_watts"
        case maxWatts = "max_watts"
        case weightedAverageWatts = "weighted_average_watts"
        case kilojoules
        case hasHeartrate = "has_heartrate"
        case averageHeartrate = "average_heartrate"
        case maxHeartrate = "max_heartrate"
        case elevHigh = "elev_high"
        case elevLow = "elev_low"
        case uploadID = "upload_id"
        case uploadIDStr = "upload_id_str"
        case externalID = "external_id"
        case prCount = "pr_count"
    }
}

struct Map: Codable {
    let id: String
    let summaryPolyline: String
    let resourceState: Int

    enum CodingKeys: String, CodingKey {
        case id
        case summaryPolyline = "summary_polyline"
        case resourceState = "resource_state"
    }
}
