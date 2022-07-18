//
//  ErrorViewModel.swift
//  DNF
//
//  Created by Max Rogers on 6/18/22.
//

import Foundation

class ErrorViewModel: LoadableObject {
    
    @Published var isShowingError: Bool = false
    var error: Error? {
        didSet {
            isShowingError = error != nil
        }
    }

    
}
