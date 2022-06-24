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
//        TODO    refreshable only works for lists. check this out to add to this view;
//        https://stackoverflow.com/a/72453592
            view.refreshable {
                await viewModel.load()
            }
        }
    }
}
