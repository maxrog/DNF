//
//  ProfileViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var athlete: StravaAthleteData?

    func fetchAthleteProfile() async throws {
        do {
            self.athlete = try await StravaNetworkDispatch.fetchAthleteInfo()
        } catch {
            throw error
        }
    }
    
}
