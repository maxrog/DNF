//
//  AuthStateViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

@MainActor
class AuthStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = StravaAPIConfiguration.shared.tokenData != nil
    
    func signIn(callbackUrl: URL) async throws {
        do {
            if isLoggedIn {
                signOut()
            }
            isLoggedIn = try await AuthTokenManager.shared.handleStravaOAuthCallback(callbackUrl)
        } catch {
            throw error
        }
    }
    
    func signOut() {
        StravaAPIConfiguration.shared.tokenData = nil
        KeychainManager.shared.delete(account: .strava)
        isLoggedIn = false
    }
}
