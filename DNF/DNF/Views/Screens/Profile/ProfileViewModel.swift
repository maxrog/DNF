//
//  ProfileViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

class ProfileViewModel: LoadableObject {
    
    @Published var athlete: StravaAthleteData?

    @MainActor
    override func load() async {
        do {
            self.athlete = try await StravaNetworkDispatch.fetchAthleteInfo()
            loadingState = .complete
        } catch {
            loadingState = .failed(error)
        }
    }
    
}
