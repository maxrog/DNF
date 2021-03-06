//
//  LoadableObject.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

/*
 Loadable Object superclass that allows us to generalize a view for loading states in DNFLoadingView
 */
class LoadableObject: ObservableObject {
    
    @Published var loadingState: LoadingState = .loading
    
    @MainActor
    func load() async {
        let message = "You need to override the load function to fetch specific data"
        DNFLogger.log(.fatal, message, sender: String(describing: self))
    }
    
}

enum LoadingState: Equatable {
    
    case loading
    case failed(Error)
    case complete
    case idle
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.complete, .complete):
            return true
        case (.idle, .idle):
            return true
        default:
            return false
        }
    }
}
