//
//  ProfileView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct ProfileView: View {
//    TODO if keep switching tabs it errors out. figure out why. maybe need charles. or reset loading state on task load time?
    @EnvironmentObject var authViewModel: AuthStateViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        DNFLoadingView({
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
        }, viewModel: profileViewModel)
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
