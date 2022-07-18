//
//  StravaAuthEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

struct StravaAuthEndpoint: Endpoint {
    
    // type of url to build (if user has Strava app downloaded)
    var type: StravaAuthRequestType
    
    // state is passed along for context restoration after redirect
    let appState: String
    
    var baseURL: String {
        return type == .web ? "https://www.strava.com/" : "strava://"
    }
    var path: String {
        "oauth/mobile/authorize"
    }
    var queryParams: [String : String]? {
        let clientId = StravaAPIConfiguration.shared.clientId
        let redirect = StravaAPIConfiguration.shared.redirect
        
        return ["client_id" : clientId,
                "redirect_uri" : redirect,
                "response_type" : "code",
                "scope" : "activity:read_all",
                "state" : appState]
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaAuthRequestType {
    case app, web
}
