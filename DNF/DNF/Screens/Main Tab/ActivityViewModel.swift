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
    func fetchActivities() async {
        do {
            loadingState = .loading
            let activityData = try await StravaNetworkDispatch.fetchAthleteActivities()
            self.activityData = activityData
            loadingState = .finished
        } catch {
            loadingState = .failed(error)
        }
    }
    
}
