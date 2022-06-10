//
//  StravaAuthEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

struct StravaAuthEndpoint: Endpoint {
    
    var type: StravaAuthType
    let appState: String
    
    var baseURL: String {
        return "https://www.strava.com/" 
    }
    var path: String {
        "oauth/mobile/authorize"
    }
    var queryParams: [String : String]? {
        let clientId = AuthenticationManager.shared.stravaClientId
        let redirect = AuthenticationManager.shared.stravaRedirect
        
        return ["client_id" : clientId,
                "redirect_uri" : redirect,
                "response_type" : "code",
                "scope" : "activity:read_all",
                "state" : appState]
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaAuthType {
    case app, web
}
