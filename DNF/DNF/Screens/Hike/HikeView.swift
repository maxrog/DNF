//
//  HikeView.swift
//  DNF
//
//  Created by Max Rogers on 6/16/22.
//

import SwiftUI

struct HikeView: View {
    
    @EnvironmentObject var activityViewModel: ActivityViewModel
    private var monthlyHikes: [StravaActivity] {
        activityViewModel.activityData?.hikeActivities.filter( { Date().month == $0.startDate.month } ) ?? []
    }
    
    var body: some View {
        DNFLoadingView({
            Text("June")
            Text("Distance:")
            Text("Elevation gain:")
            List(monthlyHikes) { hike in
                Text(hike.startDate.formatted(date: .abbreviated, time: .shortened))
                Text(hike.name)
                Text("Elevation Gain: \(hike.elevationGain)")
                Text("Elevation Low: \(hike.elevLow)")
                Text("Elevation High: \(hike.elevHigh)")
                
            }
        }, viewModel: activityViewModel)
    }
    
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView()
    }
}
