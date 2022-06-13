//
//  TodayViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

@MainActor
class TodayViewModel: ObservableObject {
    
    @Published var featuredActivity: StravaActivity?
    
    func fetchActivities() async throws {
        do {
            let activityData = try await StravaNetworkDispatch.fetchAthleteActivities()
            self.featuredActivity = activityData.featuredActivity
        } catch {
            throw error
        }
    }
    
}
