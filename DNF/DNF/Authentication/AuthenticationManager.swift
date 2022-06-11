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
    static let authRedirectUrlScheme = "myapp"
    
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
    
    func handleStravaOAuthCallback(_ url: URL) {
        guard let code = url["code"] else { return }
        if let state = url["state"] {
            // state describing where authentication happened
        }
        Task {
            do {
                let tokenData = try await StravaNetworkDispatch.fetchAccessToken(with: code)
                print(tokenData.accessToken)
                // TODO save tokens in keychain/ setup refresh 
            } catch {
                // TODO display alert
                let errorMessage = error.localizedDescription
                DNFLogger.log(.error, errorMessage, sender: String(describing: self))
            }
        }
    }
}
