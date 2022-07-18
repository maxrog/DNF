//
//  TodayView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct TodayView: View {
    
    @State private var showList = false
    
    // Latest featured activity
    @StateObject var todayViewModel: TodayViewModel
    var featuredActivity: StravaActivity? {
        todayViewModel.activity
    }

    var body: some View {
        GeometryReader { geo in
            DNFLoadingView({
                VStack {
                    VStack(spacing: 12) {
                        DNFText(featuredActivity?.name ?? "")
                            .font(.title)
                        if let region = featuredActivity?.mapRegion,
                           let coordinates = featuredActivity?.map?.lineCoordinates {
                            DNFMapView(region: region, lineCoordinates: coordinates)
                                .frame(height: geo.size.height / 4)
                                .cornerRadius(12)
                        }
                        DNFText(featuredActivity?.startDate.formatted(date: .abbreviated, time: .shortened))
                        DNFText("Miles: \(featuredActivity?.distanceUI ?? "")")
                        DNFText("Time On Feet: \(featuredActivity?.elapsedTime ?? "")")
                        DNFText("Elevation Gain: \(featuredActivity?.elevationGain ?? 0) ft")
                    }.padding()
                    Spacer()
                    
                    // TODO maybe make this floating button on bottom right -- easier to access
                    Button {
                        showList.toggle()
                    } label: {
                        DNFButton(title: "View More")
                    }
                    Spacer()
                        .frame(height: 20)
                }
            }, viewModel: todayViewModel)
            .sheet(isPresented: $showList) {
                // TODO see if possible to have this only go up screen halfway by default
                ListView()
            }
        }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(todayViewModel: .init(activityId: nil))
    }
}
