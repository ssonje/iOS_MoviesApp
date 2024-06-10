//
//  ActivityIndicatorView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 06/06/24.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        // NO-OP
    }

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}

#Preview {
    ActivityIndicatorView()
}
