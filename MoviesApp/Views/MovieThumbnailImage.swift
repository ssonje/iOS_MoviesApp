//
//  MovieThumbnailImage.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 05/06/24.
//

import SwiftUI

struct MovieThumbnailImage: View {

    // MARK: - Properties

    @ObservedObject var imageLoader = ImageLoader()
    let imageURL: URL?

    // MARK: - View

    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            if let imageURL = imageURL {
                self.imageLoader.loadImage(with: imageURL)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    MovieThumbnailImage(imageURL: URL(string: "https://image.tmdb.org/t/p/w500/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg") ?? nil)
}

#endif
