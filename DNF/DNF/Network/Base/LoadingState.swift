//
//  LoadingState.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import Foundation

enum LoadingState {
    case loading
    case failed(Error)
    case complete
}

class LoadableObject: ObservableObject {
    
    @Published var loadingState: LoadingState = .loading
    
}
