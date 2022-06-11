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
    
    init() {
        /// perform and work necessary on app launch
    }
    
    var body: some Scene {
        WindowGroup {
            StravaAuthView()
                .onOpenURL { url in
                    guard let scheme = url.scheme else { return }
                    switch scheme {
                    case AuthenticationManager.authRedirectUrlScheme:
                        AuthenticationManager.shared.handleStravaOAuthCallback(url)
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
