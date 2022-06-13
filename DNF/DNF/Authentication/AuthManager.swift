//
//  AuthManager.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

/*
 Token Manager for maintaining auth tokens
 */

actor AuthTokenManager {
    
    static let shared = AuthTokenManager()
    private init() {}
    
    private var stravaRefreshTask: Task<StravaTokenData, Error>?

}

// MARK: Redirect on initial authentication

extension AuthTokenManager {
    
    func handleStravaOAuthCallback(_ url: URL) async throws -> Bool {
        guard let code = url["code"] else { return false }
        do {
            let tokenData = try await StravaNetworkDispatch.fetchAccessTokens(with: code)
            StravaAPIConfiguration.shared.tokenData = tokenData
            return true
        } catch {
            let message = error.localizedDescription
            DNFLogger.log(.error, message, sender: String(describing: self))
            throw error
        }
    }
}

// MARK: Token Refresh Handling

extension AuthTokenManager {
    
    func validToken() async throws -> StravaTokenData {
        // We have a refresh task in flight, so don't send duplicate request
        if let handle = stravaRefreshTask {
            return try await handle.value
        }
        
        // We aren't waiting for a refresh, and we don't have anything stored - user needs to authenticate
        guard let tokenData = StravaAPIConfiguration.shared.tokenData else {
            throw RequestError.missingToken
        }
        
        // We have a valid token, return it
        if tokenData.isValid {
            return tokenData
        }
        
        // We have no valid token yet, let's refresh
        return try await refreshStravaToken()
    }
    
    /*
     Create a new Task instance so that we can store it in our AuthManager.
     This task can throw if refreshing the token fails, and it will update the current token when the refresh succeeds.
     Use defer to make sure that refreshTask gets set to to nil before completing the task.
     * Don't need to await access to refreshTask because this newly created Task will run on the AuthManager actor automatically due to the way Structured Concurrency works in Swift.
     */
    
    func refreshStravaToken() async throws -> StravaTokenData {
        // We have a refresh task in flight, so don't send duplicate request
        if let refreshTask = stravaRefreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> StravaTokenData in
            // clear out refresh task once we finish
            defer { stravaRefreshTask = nil }
            
            let newTokenData = try await StravaNetworkDispatch.refreshToken()
            StravaAPIConfiguration.shared.tokenData = newTokenData
            return try await StravaNetworkDispatch.refreshToken()
        }
        self.stravaRefreshTask = task
        
        return try await task.value
    }
    
}
