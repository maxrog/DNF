//
//  ActivityViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

class ActivityViewModel: LoadableObject {
    
    @Published var activityData: StravaActivityData?
    
    @MainActor
    override func load() async {
        do {
            let activityData = try await StravaNetworkDispatch.fetchAthleteActivities()
            self.activityData = activityData
            loadingState = .complete
        } catch {
            loadingState = .failed(error)
        }
    }
    
}
