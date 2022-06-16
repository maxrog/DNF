//
//  StravaAPIConfiguration.swift
//  DNF
//
//  Created by Max Rogers on 6/12/22.
//

import Foundation

/*
 Values for Strava API Configuration
 */

class StravaAPIConfiguration {
    
    static let shared = StravaAPIConfiguration()
    
    var baseUrl: String
    var clientId: String
    var APIKey: String
    var redirect: String
    
    var athleteId: String {
        guard let id = tokenData?.athleteId else {
            let message = "Missing athlete ID"
            DNFLogger.log(.fatal, message, sender: String(describing: self))
            return ""
        }
        return "\(id)"
    }
    
    private init() {
        let stravaPlist = FileManager.plist(named: "NetworkConfiguration", childName: "Strava")
        self.baseUrl = stravaPlist["StravaBaseUrl"] as? String ?? ""
        self.clientId = stravaPlist["StravaClientId"] as? String ?? ""
        self.APIKey = stravaPlist["StravaAPIKey"] as? String ?? ""
        self.redirect = stravaPlist["StravaRedirectURI"] as? String ?? ""
    }

    var tokenData: StravaTokenData? {
        get {
            return KeychainManager.shared.fetch(account: .strava, type: StravaTokenData.self)
        }
        set {
            KeychainManager.shared.save(newValue, account: .strava)
        }
    }
    
    var hasTokens: Bool {
        guard let data = tokenData else { return false }
        return data.accessToken.count > 0 && data.refreshToken.count > 0
    }
    
}

// MARK: Static values

extension StravaAPIConfiguration {
    
    // To redirect straight to app instead of website, this was what Strava API requires...
    static let authRedirectUrlScheme = "myapp"
    
    static let runActivityType = "Run"
    static let hikeActivityType = "Hike"
    static let walkActivityType = "Walk"
    
}
