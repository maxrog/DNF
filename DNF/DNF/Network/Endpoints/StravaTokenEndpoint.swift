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
    
    init(redirectCode: String? = nil, tokenType: StravaTokenRequestType) {
        self.redirectCode = redirectCode
        self.tokenType = tokenType
    }
    
    var methodType: RequestMethod {
        .post
    }
    var path: String {
        "/oauth/token"
    }
    var queryParams: [String : String]? {
        let clientId = StravaAPIConfiguration.shared.stravaClientId
        let key = StravaAPIConfiguration.shared.stravaAPIKey
        
        let token = StravaAPIConfiguration.shared.stravaTokenData?.refreshToken ?? ""
        
        switch tokenType {
        case .access:
            return ["client_id" : clientId,
                    "client_secret" : key,
                    "code" : redirectCode ?? "",
                    "grant_type" : "authorization_code"]
        case .refresh:
            return ["client_id" : clientId,
                    "client_secret" : key,
                    "refresh_token" : token,
                    "grant_type" : "refresh_token"]
        }
    }
    
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaTokenRequestType {
    case access, refresh
}
