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
    
    // MARK: Member Data
    
    /*
     https://www.donnywals.com/building-a-token-refresh-flow-with-async-await-and-swift-concurrency/
     Use something like this to check if we should try to refresh token if get failed call
     */
    
    
}
