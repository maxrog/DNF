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
            loadingState = .loading
            self.stats = try await StravaNetworkDispatch.fetchAthleteStats()
            loadingState = .finished
        } catch {
            loadingState = .failed(error)
        }
    }
    
}
