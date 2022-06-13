//
//  TodayView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var todayViewModel = TodayViewModel()
    
    var body: some View {
        VStack {
            Text(todayViewModel.featuredActivity?.name ?? "")
            Text(todayViewModel.featuredActivity?.startDate.formatted(date: .abbreviated, time: .shortened) ?? "")
            Text("Miles: \(todayViewModel.featuredActivity?.distance ?? 0.0)")
            Text("Time: \(todayViewModel.featuredActivity?.elapsedTime ?? "")")
        }
        .task {
            do {
                try await todayViewModel.fetchActivities()
            } catch {
                // TODO: Error handling
                let message = error.localizedDescription
            }
        }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
