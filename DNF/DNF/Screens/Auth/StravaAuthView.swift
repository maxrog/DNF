//
//  StravaAuthView.swift
//  DNF
//
//  Created by Max Rogers on 6/8/22.
//

import SwiftUI

struct StravaAuthView: View {
    
    @State var authViewModel = StravaAuthViewModel()
    
    var body: some View {
        Button {
            authViewModel.presentAuth()
        } label: {
            DNFButton(title: "Strava Auth")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StravaAuthView()
    }
}
