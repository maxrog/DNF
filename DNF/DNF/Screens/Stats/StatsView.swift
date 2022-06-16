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
                    Text("Recent")
                        .font(.title)
                    Text("Count: \(statsViewModel.stats?.recentRunTotals?.count ?? 0)")
                    Text("Distance: \(statsViewModel.stats?.recentRunTotals?.distance ?? 0)")
                    Text("Time On Feet: \(statsViewModel.stats?.recentRunTotals?.elapsedTime ?? "")")
                }
                Spacer()
                VStack {
                    Text("YTD")
                        .font(.title)
                    Text("Count: \(statsViewModel.stats?.ytdRunTotals?.count ?? 0)")
                    Text("Distance: \(statsViewModel.stats?.ytdRunTotals?.distance ?? 0)")
                    Text("Time On Feet: \(statsViewModel.stats?.ytdRunTotals?.elapsedTime ?? "")")
                }
                Spacer()
                VStack {
                    Text("All")
                        .font(.title)
                    Text("Count: \(statsViewModel.stats?.allRunTotals?.count ?? 0)")
                    Text("Distance: \(statsViewModel.stats?.allRunTotals?.distance ?? 0)")
                    Text("Time On Feet: \(statsViewModel.stats?.allRunTotals?.elapsedTime ?? "")")
                }
                Spacer()
            }
        }, viewModel: statsViewModel)
    }
    
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
