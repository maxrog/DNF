//
//  ProfileView.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthStateViewModel
    @State var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: profileViewModel.athlete?.profile ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Button {
                authViewModel.signOut()
            } label: {
                DNFButton(title: "Logout")
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
