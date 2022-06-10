//
//  AuthenticationManager.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

/*
 Manager for maintaining auth state
 */

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    // Strava access
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
    
    func handleStravaOAuthCallback(_ url: URL?) {
        guard let url = url else { return }
        let components = url.pathComponents
        print(components)
    }
}
