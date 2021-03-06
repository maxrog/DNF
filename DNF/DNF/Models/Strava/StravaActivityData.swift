//
//  StravaActivityData.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation
import MapKit
import Polyline

struct StravaActivityData {
    /// All of the past <= 200 activities
    var allActivities: [StravaActivity]
    
    /// Subset of allActivities that are run type
    var runActivities: [StravaActivity]
    
    /// Subset of allActivities that are hike type
    var hikeActivities: [StravaActivity]

    /// The most recent activity
    var featuredActivity: StravaActivity? {
        let firstRun = runActivities.first
        let firstHike = hikeActivities.first
        
        // if have no hike, return run
        guard let hike = firstHike else {
            return firstRun
        }
        // if no run return first hike
        guard let run = firstRun else {
            return firstHike
        }
        
        // return longest of two
        return run.distance > hike.distance ? run : hike
    }
    
}

// TODO clean this up / documentation
// TODO when we get activity detail we reuse this data model but a lot more info is available if want to add it at some point
struct StravaActivity: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    
    static func == (lhs: StravaActivity, rhs: StravaActivity) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let type, sportType: String
    let photoCount: Int
    let map: Map?
    let startLatlng, endLatlng: [Double]
    let averageSpeed, maxSpeed, averageCadence, averageWatts: Double?
    let maxWatts, weightedAverageWatts: Int?
    let kilojoules: Double?
    let hasHeartrate: Bool
    let averageHeartrate: Double
    let maxHeartrate: Int
    let elevHigh, elevLow: Int?
    let uploadID: Int
    let uploadIDStr, externalID: String
    let prCount: Int
    
    // To be processed, raw values
    private let _distance: Double?
    private let _elapsedTime: Int?
    private let _startDate: String?
    private let _totalElevationGain: Int?
    
    // Public computed variables
    
    /// The distance ran, in miles
    public var distance: Double {
        _distance?.metersToMilesValue ?? 0
    }
    /// The distance ran, in miles in UI format
    public var distanceUI: String {
        _distance?.metersToMilesStringValue ?? ""
    }
    /// The elapsed time, neatly formatted
    public var elapsedTime: String {
        _elapsedTime?.hhmmssStringValue ?? ""
    }
    /// The date the activity took place
    public var startDate: Date {
        _startDate?.isoDate ?? Date()
    }
    /// The elevation gain, in feet
    public var elevationGain: Int {
        _totalElevationGain?.metersToFeetValue ?? 0
    }
    /// The region to show in our DNFMapView
    public var mapRegion: MKCoordinateRegion? {
        guard startLatlng.indices.contains(0),
              startLatlng.indices.contains(1) else { return nil }
        return MKCoordinateRegion(
             center: CLLocationCoordinate2D(latitude: startLatlng[0], longitude: startLatlng[1]),
             span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
        case _distance = "distance"
        case _elapsedTime = "elapsed_time"
        case _startDate = "start_date"
        case _totalElevationGain = "total_elevation_gain"
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self._distance = try container.decodeIfPresent(Double.self, forKey: ._distance)
        self._elapsedTime = try container.decodeIfPresent(Int.self, forKey: ._elapsedTime)
        self._startDate = try container.decodeIfPresent(String.self, forKey: ._startDate)
        self._totalElevationGain = try container.decodeIfPresent(Int.self, forKey: ._totalElevationGain)
        self.sportType = try container.decode(String.self, forKey: .sportType)
        self.photoCount = try container.decode(Int.self, forKey: .photoCount)
        self.map = try container.decodeIfPresent(Map.self, forKey: .map)
        self.startLatlng = try container.decode([Double].self, forKey: .startLatlng)
        self.endLatlng = try container.decode([Double].self, forKey: .endLatlng)
        self.averageSpeed = try container.decodeIfPresent(Double.self, forKey: .averageSpeed)
        self.maxSpeed = try container.decodeIfPresent(Double.self, forKey: .maxSpeed)
        self.averageCadence = try container.decodeIfPresent(Double.self, forKey: .averageCadence)
        self.averageWatts = try container.decodeIfPresent(Double.self, forKey: .averageWatts)
        self.maxWatts = try container.decodeIfPresent(Int.self, forKey: .maxWatts)
        self.weightedAverageWatts = try container.decodeIfPresent(Int.self, forKey: .weightedAverageWatts)
        self.kilojoules = try container.decodeIfPresent(Double.self, forKey: .kilojoules)
        self.hasHeartrate = try container.decode(Bool.self, forKey: .hasHeartrate)
        self.averageHeartrate = try container.decode(Double.self, forKey: .averageHeartrate)
        self.maxHeartrate = try container.decode(Int.self, forKey: .maxHeartrate)
        self.elevHigh = try container.decodeIfPresent(Int.self, forKey: .elevHigh)
        self.elevLow = try container.decodeIfPresent(Int.self, forKey: .elevLow)
        self.uploadID = try container.decode(Int.self, forKey: .uploadID)
        self.uploadIDStr = try container.decode(String.self, forKey: .uploadIDStr)
        self.externalID = try container.decode(String.self, forKey: .externalID)
        self.prCount = try container.decode(Int.self, forKey: .prCount)
    }
}

struct Map: Codable {
    let id: String
    let summaryPolyline: String?
    let polyline: String?
    let resourceState: Int
    
    /// The polyline coordinates to show in our DNFMapView
    public var lineCoordinates: [CLLocationCoordinate2D] {
        let encodedPolyline = polyline ?? summaryPolyline
        guard let encodedPolyline = encodedPolyline else {
            return []
        }
        let decodedPolyline = Polyline.init(encodedPolyline: encodedPolyline)
        guard let polyCoords = decodedPolyline.coordinates else { return [] }
        return polyCoords.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
    }

    enum CodingKeys: String, CodingKey {
        case id
        case polyline
        case summaryPolyline = "summary_polyline"
        case resourceState = "resource_state"
    }
}
