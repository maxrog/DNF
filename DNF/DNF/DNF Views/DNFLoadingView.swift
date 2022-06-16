//
//  DNFLoadingView.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import SwiftUI

struct DNFLoadingView<Content: View>: View {
    
//    TODO why did we need to set this to observedOBject (apparently recreated each time view is destroyed) instead of state object? Also check to make sure duplicate requests aren't firing off
    @ObservedObject var viewModel: LoadableObject
    let loadedContent: Content
    
    init(@ViewBuilder _ content: () -> Content, viewModel: LoadableObject) {
        self.loadedContent = content()
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .complete:
                loadedContent
            case .loading:
                ProgressView()
                    .task {
                        await viewModel.load()
                    }
            case .failed(let error):
                // TODO present error
                Text("ERROR :\(error.localizedDescription)")
                    .font(.largeTitle)
            }
        }
    }
}
