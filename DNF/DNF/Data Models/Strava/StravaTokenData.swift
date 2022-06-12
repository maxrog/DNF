//
//  StravaTokenData.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaTokenData: Codable {
    let tokenType: String
    let expiresAt, expiresIn: Int
    let refreshToken, accessToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
    }
    
    var isValid: Bool {
        let currentDate = Date()
        let expireDate = Date(timeIntervalSince1970: TimeInterval(expiresAt))
        return currentDate < expireDate
    }
}
