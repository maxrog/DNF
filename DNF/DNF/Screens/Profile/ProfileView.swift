//
//  ProfileView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthStateViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            switch profileViewModel.loadingState {
            case .complete:
                VStack(spacing: 12) {
                    AsyncImage(url: URL(string: profileViewModel.athlete?.profile ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.red
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    
                    Text(profileViewModel.athlete?.firstname ?? "-")
                    Text(profileViewModel.athlete?.lastname ?? "-")
                    Button {
                        authViewModel.signOut()
                    } label: {
                        DNFButton(title: "Logout")
                    }
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                // TODO
                Text("Error: \(error.localizedDescription)")
            }
        }.task {
            await profileViewModel.fetchProfile()
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
