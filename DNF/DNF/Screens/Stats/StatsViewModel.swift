//
//  StatsViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

@MainActor
class StatsViewModel: ObservableObject {
    
    @Published var stats: StravaAthleteStatsData?
    
    func fetchStats() async throws {
        do {
            self.stats = try await StravaNetworkDispatch.fetchAthleteStats()
        } catch {
            throw error
        }
    }
    
}
