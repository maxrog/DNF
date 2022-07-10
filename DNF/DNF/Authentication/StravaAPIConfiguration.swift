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
            if let athlete = newValue?.athlete {
                self.athlete = athlete
            }
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
    static let athleteUDKey = "rogers.max.DNF.app.athleteKey"
    
    static let runActivityType = "Run"
    static let hikeActivityType = "Hike"
    static let walkActivityType = "Walk"
    
}

// MARK: Athlete

// We will save Athlete data separately because it comes with first auth token call but not on subsequent refresh's.
// This means once we refresh and it's nil, the keychain object overrides it with nil, causing a missing athlete

extension StravaAPIConfiguration {
    
    var athlete: StravaAthleteData? {
        get {
            if let data = UserDefaults.standard.object(forKey: StravaAPIConfiguration.athleteUDKey) as? Data,
               let athlete = try? JSONDecoder().decode(StravaAthleteData.self, from: data) {
                return athlete
            } else {
                return nil
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: StravaAPIConfiguration.athleteUDKey)
            } else if newValue == nil {
                UserDefaults.standard.removeObject(forKey: StravaAPIConfiguration.athleteUDKey)
            }
        }
    }
    
    var athleteId: String {
        guard let id = self.athlete?.id else {
            let message = "Missing athlete ID"
            DNFLogger.log(.fatal, message, sender: String(describing: self))
            return ""
        }
        return "\(id)"
    }
    
    
}
