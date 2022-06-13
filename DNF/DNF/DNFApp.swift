//
//  DNFApp.swift
//  DNF
//
//  Created by Max Rogers on 6/8/22.
//

import SwiftUI

@main
struct DNFApp: App {
    
    @Environment(\.scenePhase) var scenePhase

    @StateObject var authStateViewModel = AuthStateViewModel()
    
    init() {
        /// perform any work necessary on app launch
    }
    
    var body: some Scene {
        WindowGroup {
            DNFAuthSwitchView()
            .environmentObject(authStateViewModel)
            .onOpenURL { url in
                    guard let scheme = url.scheme else { return }
                    switch scheme {
                    case StravaAPIConfiguration.authRedirectUrlScheme:
                        Task {
                            do {
                                try await authStateViewModel.signIn(callbackUrl: url)
                            } catch {
                                // TODO: Error handling
                                let message = error.localizedDescription
                            }
                        }
                    default:
                        break
                    }
                }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch scenePhase {
            case .active:
                /// application became active
                break
            case .background:
                /// application went to background
                break
            case .inactive:
                /// application became inactive
                break
            default:
                break
            }
        }
    }
}

/*
 View that handles which screen to show on launch
 */

struct DNFAuthSwitchView: View {
    
    @EnvironmentObject var authViewModel: AuthStateViewModel
    
    var body: some View {
        if authViewModel.isLoggedIn {
            MainTabView()
        } else {
            StravaOAuthView()
        }
    }
}
