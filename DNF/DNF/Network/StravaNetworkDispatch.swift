//
//  StravaNetworkDispatch.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaNetworkDispatch {
    
    // MARK: Tokens
    
    static func fetchAccessToken(with redirectCode: String) async throws -> StravaTokenData {
        let tokenEndpoint = StravaTokenEndpoint(redirectCode: redirectCode, tokenType: .access)
        guard let urlRequest = tokenEndpoint.urlRequest else {
            throw RequestError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let stravaTokenData = try JSONDecoder().decode(StravaTokenData.self, from: data)
        
        return stravaTokenData
    }
    
    
}
