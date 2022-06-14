//
//  StatsViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

class StatsViewModel: LoadableObject {
    
    @Published var stats: StravaAthleteStatsData?
    
    @MainActor
    func fetchStats() async {
        do {
            self.stats = try await StravaNetworkDispatch.fetchAthleteStats()
            loadingState = .complete
        } catch {
            loadingState = .failed(error)
        }
    }
    
}
