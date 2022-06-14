//
//  ActivityViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

@MainActor
class ActivityViewModel: ObservableObject {
    
    @Published var activityData: StravaActivityData?
    
    func fetchActivities() async throws {
        do {
            let activityData = try await StravaNetworkDispatch.fetchAthleteActivities()
            self.activityData = activityData
        } catch {
            throw error
        }
    }
    
}
