//
//  LoadingState.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case failed(Error)
    case finished
}

class LoadableObject: ObservableObject {
    
    @Published var loadingState: LoadingState
    
    init(loadingState: LoadingState = .idle) {
        self.loadingState = loadingState
    }
    
}
