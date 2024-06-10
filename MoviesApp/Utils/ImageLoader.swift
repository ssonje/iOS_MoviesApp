//
//  ImageLoader.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation
import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {

    // MARK: - Properties

    @Published var image: UIImage?
    @Published var isLoading = false

    var imageCache = _imageCache

    // MARK: - API's

    func loadImage(with url: URL) {
        let urlString = url.absoluteString

        // Check whether image is cached or not, if yes, return cached image
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            MoviesAppLogger.sharedInstance.debug("Returning image with urlString: \(urlString) from cache.")
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                MoviesAppLogger.sharedInstance.debug("Self shouldn't be nil.")
                return
            }

            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    MoviesAppLogger.sharedInstance.debug("Failed to get UIImage from the Image URL.")
                    return
                }

                // Save the image into the cache
                self.imageCache.setObject(image, forKey: urlString as AnyObject)

                // Update the image property of this view model
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        MoviesAppLogger.sharedInstance.debug("Self shouldn't be nil.")
                        return
                    }
                    self.image = image
                }
            } catch {
                MoviesAppLogger.sharedInstance.debug("Operation for getting image from the URL and saving image into the cache is failed with error: \(error.localizedDescription)")
            }
        }
    }
}
