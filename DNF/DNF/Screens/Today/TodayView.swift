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
                VStack(spacing: 12) {
                    Text(featuredActivity?.name ?? "")
                        .font(.title)
                    if let region = featuredActivity?.mapRegion,
                       let coordinates = featuredActivity?.map?.lineCoordinates {
                        DNFMapView(region: region, lineCoordinates: coordinates)
                            .frame(height: geo.size.height / 4)
                            .cornerRadius(12)
                    }
                    Text(featuredActivity?.startDate.formatted(date: .abbreviated, time: .shortened) ?? "")
                    Text("Miles: \(featuredActivity?.distanceUI ?? "")")
                    Text("Time On Feet: \(featuredActivity?.elapsedTime ?? "")")
                    Text("Elevation Gain: \(featuredActivity?.elevationGain ?? 0) ft")
                }.padding()
                Spacer()
                
                Button {
                    showList.toggle()
                } label: {
                    DNFButton(title: "View More")
                }
            }, viewModel: todayViewModel)
            .sheet(isPresented: $showList) {
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
