//
//  StravaOAuthViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation
import AuthenticationServices

class StravaOAuthViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    
    // ASWebAuth Conformance. System will find best spot to present authentication
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    @MainActor
    func presentAuth() {
        // Check if can open the app first, otherwise use OAuth
        var authEndpoint = StravaAuthEndpoint(type: .app, appState: "Onboard")
        guard let appUrl = authEndpoint.url else { return }
        if UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl)
        } else {
            // OAuth
            authEndpoint.type = .web
            guard let url = authEndpoint.url else { return }
            
            let authSession = ASWebAuthenticationSession(url: url, callbackURLScheme: StravaAPIConfiguration.authRedirectUrlScheme) { url, error in
                guard error == nil else {
                    let message = "OAuth error receiving callback"
                    DNFLogger.log(.error, message, sender: String(describing: self))
                    return
                }
            }
            
            authSession.presentationContextProvider = self
            authSession.prefersEphemeralWebBrowserSession = true
            authSession.start()
        }
    }
    
    
}
