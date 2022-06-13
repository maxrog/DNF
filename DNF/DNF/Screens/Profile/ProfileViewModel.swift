//
//  ProfileViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var athlete: StravaAthleteData?
    
    init() {
        Task {
            do {
                self.athlete = try await fetchAthleteProfile()
            } catch {
                
            }
        }
    }
    
    func fetchAthleteProfile() async throws -> StravaAthleteData {
        do {
            return try await StravaNetworkDispatch.fetchAthleteInfo()
        } catch {
            throw error
        }
    }
    
}
