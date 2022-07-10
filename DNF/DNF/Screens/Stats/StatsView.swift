//
//  StatsView.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import SwiftUI

struct StatsView: View {
    
    @StateObject var statsViewModel = StatsViewModel()
    
    var body: some View {
        DNFLoadingView({
            VStack {
                Spacer()
                VStack {
                    DNFText("Recent")
                        .font(.title)
                    DNFText("Count: \(statsViewModel.stats?.recentRunTotals?.count ?? 0)")
                    DNFText("Distance: \(statsViewModel.stats?.recentRunTotals?.distanceUI ?? "")")
                    DNFText("Time On Feet: \(statsViewModel.stats?.recentRunTotals?.elapsedTime ?? "")")
                    DNFText("Last Hard Workout: (Calculate this based on pace/distance? if not supplied...")
                }
                Spacer()
                VStack {
                    DNFText("YTD")
                        .font(.title)
                    DNFText("Count: \(statsViewModel.stats?.ytdRunTotals?.count ?? 0)")
                    DNFText("Distance: \(statsViewModel.stats?.ytdRunTotals?.distanceUI ?? "")")
                    DNFText("Time On Feet: \(statsViewModel.stats?.ytdRunTotals?.elapsedTime ?? "")")
                }
                Spacer()
                VStack {
                    DNFText("All")
                        .font(.title)
                    DNFText("Count: \(statsViewModel.stats?.allRunTotals?.count ?? 0)")
                    DNFText("Distance: \(statsViewModel.stats?.allRunTotals?.distanceUI ?? "")")
                    DNFText("Time On Feet: \(statsViewModel.stats?.allRunTotals?.elapsedTime ?? "")")
                }
                Spacer()
            }
        }, viewModel: statsViewModel)
    }
    
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
