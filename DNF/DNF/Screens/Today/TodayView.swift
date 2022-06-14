//
//  TodayView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct TodayView: View {
    
    @EnvironmentObject var activityViewModel: ActivityViewModel
    private var featuredActivity: StravaActivity? {
        activityViewModel.activityData?.featuredActivity
    }
    
    var body: some View {
        ZStack {
            switch activityViewModel.loadingState {
            case .complete:
                VStack(spacing: 12) {
                    Text(featuredActivity?.name ?? "")
                        .font(.title)
                    Text(featuredActivity?.startDate.formatted(date: .abbreviated, time: .shortened) ?? "")
                    Text("Miles: \(featuredActivity?.distance ?? 0.0)")
                    Text("Time On Feet: \(featuredActivity?.elapsedTime ?? "")")
                    Text("Elevation Gain: \(featuredActivity?.elevationGain ?? 0) ft")
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                // TODO
                Text("Error: \(error.localizedDescription)")
            }
        }.task {
            await activityViewModel.fetchActivities()
        }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
