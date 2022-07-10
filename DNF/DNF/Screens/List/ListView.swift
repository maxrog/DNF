//
//  ListView.swift
//  DNF
//
//  Created by Max Rogers on 7/10/22.
//

import SwiftUI

struct ListView: View {
    
    // All Activities
    @EnvironmentObject var activityViewModel: ActivityViewModel
    var activityList: [StravaActivity] {
        activityViewModel.activityData?.allActivities ?? []
    }
    @State private var selectedActivity: StravaActivity?
    
    var body: some View {
        NavigationView {
            List(activityList, selection: $selectedActivity) { activity in
                NavigationLink(destination: TodayView(todayViewModel: TodayViewModel(activityId: activity.id.stringValue))) {
                    VStack {
                        Text(activity.startDate.formatted(date: .abbreviated, time: .shortened))
                        Text(activity.name)
                        Text("Distance: \(activity.distanceUI)")
                        Text("Elevation Gain: \(activity.elevationGain)")
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
