//
//  StravaTokenEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaTokenEndpoint: Endpoint {
    
    let code: String
    
    var baseURL: String {
        return "https://www.strava.com/"
    }
    var path: String {
        "api/v3/oauth/token"
    }
    var queryParams: [String : String]? {
        let clientId = AuthenticationManager.shared.stravaClientId
        let key = AuthenticationManager.shared.stravaAPIKey
        
        return ["client_id" : clientId,
                "client_secret" : key,
                "code" : code,
                "grant_type" : "authorization_code"]
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}
