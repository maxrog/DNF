//
//  StravaNetworkDispatch.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaNetworkDispatch {
    
    // MARK: Tokens
    
    static func fetchAccessTokens(with redirectCode: String) async throws -> StravaTokenData {
        let tokenEndpoint = StravaTokenEndpoint(redirectCode: redirectCode, tokenType: .access)
        guard let urlRequest = tokenEndpoint.urlRequest else {
            throw RequestError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let stravaTokenData = try JSONDecoder().decode(StravaTokenData.self, from: data)
        
        return stravaTokenData
    }
    
    static func refreshToken() async throws -> StravaTokenData {
        let tokenEndpoint = StravaTokenEndpoint(tokenType: .refresh)
        guard let urlRequest = tokenEndpoint.urlRequest else {
            throw RequestError.invalidURL
        }
        guard StravaAPIConfiguration.shared.hasTokens else {
            throw RequestError.missingToken
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let stravaTokenData = try JSONDecoder().decode(StravaTokenData.self, from: data)
        
        return stravaTokenData
    }

}

/*
 MARK: Authorized Requests
 */

extension StravaNetworkDispatch {
    
    // MARK: Athlete data
    
    static func fetchAthleteInfo() async throws -> StravaAthleteData {
        let athleteEndpoint = StravaAthleteEndpoint(type: .info)
        
        guard let urlRequest = try await athleteEndpoint.authorizedRequest() else {
            throw RequestError.missingToken
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let athleteInfo = try JSONDecoder().decode(StravaAthleteData.self, from: data)
        
        return athleteInfo
    }
   
    static func fetchAthleteStats() async throws -> StravaAthleteStatsData {
        let athleteEndpoint = StravaAthleteEndpoint(type: .stats)
        
        guard let urlRequest = try await athleteEndpoint.authorizedRequest() else {
            throw RequestError.missingToken
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let athleteStats = try JSONDecoder().decode(StravaAthleteStatsData.self, from: data)
        
        return athleteStats
    }
    
    // MARK: Activities
    
    static func fetchAthleteActivities() async throws -> StravaActivityData {
        let athleteEndpoint = StravaActivityEndpoint(type: .list)
        
        guard let urlRequest = try await athleteEndpoint.authorizedRequest() else {
            throw RequestError.missingToken
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        var activities = try JSONDecoder().decode([StravaActivity].self, from: data)
        activities = activities.sorted(by: { $0.startDate > $1.startDate })
        let runActivities = activities.filter { $0.sportType == StravaAPIConfiguration.runActivityType }
        let hikeActivities = activities.filter {
            $0.sportType == StravaAPIConfiguration.hikeActivityType
            ||
            $0.sportType == StravaAPIConfiguration.walkActivityType
        }
        
        let activityData = StravaActivityData(allActivities: activities, runActivities: runActivities, hikeActivities: hikeActivities)
        
        DNFLogger.log(.action, "Fetched athlete activities", sender: String(describing: self))
        return activityData
    }
    
}
