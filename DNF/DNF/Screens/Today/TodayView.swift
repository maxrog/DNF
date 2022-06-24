//
//  TodayView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct TodayView: View {
    
    @ObservedObject var todayViewModel: TodayViewModel
    var activity: StravaActivity? {
        todayViewModel.activity
    }

    var body: some View {
            DNFLoadingView({
                VStack(spacing: 12) {
                    if let region = activity?.mapRegion,
                       let coordinates = activity?.map.lineCoordinates {
                        DNFMapView(region: region, lineCoordinates: coordinates)
                    }
                    Text(activity?.name ?? "")
                        .font(.title)
                    Text(activity?.startDate.formatted(date: .abbreviated, time: .shortened) ?? "")
                    Text("Miles: \(activity?.distance ?? 0.0)")
                    Text("Time On Feet: \(activity?.elapsedTime ?? "")")
                    Text("Elevation Gain: \(activity?.elevationGain ?? 0) ft")
                }
            }, viewModel: todayViewModel)
        }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(todayViewModel: .init(activityId: nil))
    }
}
