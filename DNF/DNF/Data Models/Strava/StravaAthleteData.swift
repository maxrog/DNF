//
//  StravaAthleteData.swift
//  DNF
//
//  Created by Max Rogers on 6/12/22.
//

import Foundation

struct StravaAthleteData: Codable {
    let id: Int
    let resourceState: Int
    let firstname, lastname: String
    let createdAt, updatedAt: String
    let profileMedium, profile: String

    enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case firstname, lastname
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profileMedium = "profile_medium"
        case profile
    }
}
