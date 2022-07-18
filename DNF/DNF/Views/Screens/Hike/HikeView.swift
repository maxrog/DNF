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
                    DNFText("Distance:")
                    DNFText("Elevation gain:")
                    List(monthlyHikes, selection: $selectedHike) { hike in
                            NavigationLink(destination: TodayView(todayViewModel: TodayViewModel(activityId: hike.id.stringValue))) {
                                VStack {
                                    DNFText(hike.startDate.formatted(date: .abbreviated, time: .shortened))
                                    DNFText(hike.name)
                                    DNFText("Distance: \(hike.distanceUI)")
                                    DNFText("Elevation Gain: \(hike.elevationGain)")
                                    DNFText("Elevation Low: \(hike.elevLow ?? 0)")
                                    DNFText("Elevation High: \(hike.elevHigh ?? 0)")
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
