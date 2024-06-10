//
//  LoadingView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 06/06/24.
//

import SwiftUI

struct LoadingView: View {

    // MARK: - Properties

    @EnvironmentObject var moviesViewModel: MoviesViewModel
    let retryAction: (() -> ())?

    // MARK: - View

    var body: some View {
        ZStack {
            if moviesViewModel.isDataFetching {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            }

            if let error = moviesViewModel.error {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error.localizedDescription)
                            .font(.headline)
                            .foregroundStyle(.red)

                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LoadingView(retryAction: nil)
}
