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
    
    // To redirect straight to app instead of website, this was what Strava API requires...
    static let authRedirectUrlScheme = "myapp"
    static let shared = StravaAPIConfiguration()
    
    var stravaBaseUrl: String
    var stravaClientId: String
    var stravaAPIKey: String
    var stravaRedirect: String
    
    private init() {
        let stravaPlist = FileManager.plist(named: "NetworkConfiguration", childName: "Strava")
        self.stravaBaseUrl = stravaPlist["StravaBaseUrl"] as? String ?? ""
        self.stravaClientId = stravaPlist["StravaClientId"] as? String ?? ""
        self.stravaAPIKey = stravaPlist["StravaAPIKey"] as? String ?? ""
        self.stravaRedirect = stravaPlist["StravaRedirectURI"] as? String ?? ""
    }

    var stravaTokenData: StravaTokenData? {
        get {
            return KeychainManager.shared.fetch(account: .strava, type: StravaTokenData.self)
        }
        set {
            KeychainManager.shared.save(newValue, account: .strava)
        }
    }
    
    var hasStravaTokens: Bool {
        guard let data = stravaTokenData else { return false }
        return data.accessToken.count > 0 && data.refreshToken.count > 0
    }
    
}
