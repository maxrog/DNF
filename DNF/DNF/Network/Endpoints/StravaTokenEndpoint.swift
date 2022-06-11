//
//  StravaTokenEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaTokenEndpoint: Endpoint {
    
    let redirectCode: String?
    let tokenType: StravaTokenRequestType
    
    var methodType: RequestMethod {
        .post
    }
    var path: String {
        "/oauth/token"
    }
    var queryParams: [String : String]? {
        let clientId = AuthenticationManager.shared.stravaClientId
        let key = AuthenticationManager.shared.stravaAPIKey
        
        switch tokenType {
        case .access:
            return ["client_id" : clientId,
                    "client_secret" : key,
                    "code" : redirectCode ?? "",
                    "grant_type" : "authorization_code"]
        case .refresh:
            return ["client_id" : clientId,
                    "client_secret" : key,
                    "refresh_token" : "blah",
                    "grant_type" : "refresh_token"]
        }
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaTokenRequestType {
    case access, refresh
}
