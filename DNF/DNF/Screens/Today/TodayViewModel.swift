//
//  TodayViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/23/22.
//

import Foundation
import SwiftUI

class TodayViewModel: LoadableObject {
    
    @Published var activityId: String?
    
    init(activityId: String?) {
        self.activityId = activityId
    }
    
    @Published var activity: StravaActivity?
    
    @MainActor
    override func load() async {
        do {
            self.activity = try await StravaNetworkDispatch.fetchAthleteActivity(withId: activityId)
            loadingState = .complete
        } catch {
            loadingState = .failed(error)
        }
    }
}
