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
        guard StravaAPIConfiguration.shared.hasStravaTokens else {
            throw RequestError.missingToken
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let stravaTokenData = try JSONDecoder().decode(StravaTokenData.self, from: data)
        
        return stravaTokenData
    }

}

/*
 Authorized Requests
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
    
}
