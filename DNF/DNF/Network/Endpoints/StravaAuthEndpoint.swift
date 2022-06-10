//
//  StravaAuthEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

struct StravaAuthEndpoint: Endpoint {
    
    var type: StravaAuthType
    
    var baseURL: String {
        return type == .web ? "https://www.strava.com/" : "strava://"
    }
    var path: String {
        "oauth/mobile/authorize"
    }
    var queryParams: [String : String]? {
        let stravaPlist = FileManager.plist(named: "NetworkConfiguration", childName: "Strava")
        
        guard let clientId = stravaPlist["StravaClientId"] as? String,
        let redirect = stravaPlist["StravaRedirectURI"] as? String else { return nil }
        
        return ["client_id" : clientId,
                "redirect_uri" : redirect,
                "response_type" : "code",
                "scope" : "activity:read_all"]
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaAuthType {
    case app, web
}
