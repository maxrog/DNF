//
//  DNFLoadingView.swift
//  DNF
//
//  Created by Max Rogers on 6/14/22.
//

import SwiftUI

/*
 A loading view that will handle the load cycle with shared acitivity spinners, error and idle screens.
 */

struct DNFLoadingView<Content: View>: View {
    
//    TODO why did we need to set this to observedOBject (apparently recreated each time view is destroyed) instead of state object? Also check to make sure duplicate requests aren't firing off
    @ObservedObject var viewModel: LoadableObject
    let loadedContent: Content
    
    @StateObject var errorViewModel = ErrorViewModel()
    
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
                VStack(spacing: 20) {
                    HStack(spacing: 8) {
                        Spacer()
                        Image(systemName: "tortoise.fill")
                        Image(systemName: "tortoise.fill")
                        Image(systemName: "tortoise.fill")
                        Spacer()
                    }
                    Text("\(error.localizedDescription)")
                        .font(.title)
                }.onTapGesture {
                    errorViewModel.error = error
                }
            case .idle:
                // TODO: Generic "Splash Screen or something
                VStack(spacing: 20) {
                    HStack(spacing: 8) {
                        Spacer()
                        Image(systemName: "tortoise.fill")
                        Image(systemName: "tortoise.fill")
                        Image(systemName: "tortoise.fill")
                        Spacer()
                    }
                }
            }
        }
        
        .alert(isPresented: $errorViewModel.isShowingError, content: {
            Alert(title: Text(NSLocalizedString("Error", comment: "error")),
                  message: Text("There was an error loading your data: \(self.errorViewModel.error?.localizedDescription ?? "Unknown issue.")"),
                  dismissButton:
                    .cancel(Text(NSLocalizedString("Ok", comment: "ok"))) {
                        self.errorViewModel.error = nil
                        viewModel.loadingState = .idle
                    })
        })
        
        .if(viewModel.loadingState == .idle) { view in
            view.refreshable {
                await viewModel.load()
            }
        }
    }
}
