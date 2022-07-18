//
//  StravaOAuthView.swift
//  DNF
//
//  Created by Max Rogers on 6/8/22.
//

import SwiftUI

struct StravaOAuthView: View {
    
    @StateObject var authViewModel = StravaOAuthViewModel()
    
    var body: some View {
        Button {
            authViewModel.presentAuth()
        } label: {
            DNFButton(title: "Strava Auth")
        }

    }
}

struct StravaOAuthView_Previews: PreviewProvider {
    static var previews: some View {
        StravaOAuthView()
    }
}
