//
//  MainTabView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct MainTabView: View {
    
    // Main Tab Environment Objects
    /// The athelete's list of activities
    @StateObject var activityViewModel = ActivityViewModel()
    private var featuredActivityId: String? {
        activityViewModel.activityData?.featuredActivity?.id.stringValue
    }
    
    var body: some View {
        // TODO make special loading screen for main tab view since it's like launch screen 
        DNFLoadingView({
            TabView {
                TodayView(todayViewModel: TodayViewModel(activityId: featuredActivityId))
                    .tabItem {
                        Image(systemName: "gauge")
                    }
                StatsView()
                    .tabItem {
                        Image(systemName: "star.fill")
                    }
                HikeView()
                    .tabItem {
                        Image(systemName: "pawprint.circle.fill")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "lanyardcard.fill")
                    }
            }
            .environmentObject(activityViewModel)
        }, viewModel: activityViewModel)
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
