//
//  MainTabView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "gauge")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "star.fill")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "lanyardcard.fill")
                }
        }
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
