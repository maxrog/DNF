//
//  HikeView.swift
//  DNF
//
//  Created by Max Rogers on 6/16/22.
//

import SwiftUI

// TODO probably create a list that you tap to go into more detail and load activity similar to today view (maybe even reuse view)

struct HikeView: View {
    
    @EnvironmentObject var activityViewModel: ActivityViewModel
    private var monthlyHikes: [StravaActivity] {
        activityViewModel.activityData?.hikeActivities.filter( { Date().month == $0.startDate.month } ) ?? []
    }
    @State private var selectedHike: StravaActivity?
    
    var body: some View {
        DNFLoadingView({
            NavigationView {
                VStack {
                    Text("Distance:")
                    Text("Elevation gain:")
                    List(monthlyHikes, selection: $selectedHike) { hike in
                            NavigationLink(destination: TodayView(todayViewModel: TodayViewModel(activityId: hike.id.stringValue))) {
                                VStack {
                                    Text(hike.startDate.formatted(date: .abbreviated, time: .shortened))
                                    Text(hike.name)
                                    Text("Distance: \(hike.distanceUI)")
                                    Text("Elevation Gain: \(hike.elevationGain)")
                                    Text("Elevation Low: \(hike.elevLow ?? 0)")
                                    Text("Elevation High: \(hike.elevHigh ?? 0)")
                                }
                            }
                    }
                    .lineSpacing(8)
                }
                .navigationTitle("June")
            }
        }, viewModel: activityViewModel)
    }
    
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView()
    }
}
