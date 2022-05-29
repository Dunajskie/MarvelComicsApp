//
//  UIImageView.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 25/05/2022.
//

import UIKit

extension UIImageView {

    func loadImageUsingCache(withUrl urlString : String) {
        let imageCache = NSCache<NSString, UIImage>()
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self?.image = image
                            activityIndicator.removeFromSuperview()
                        }
                    }
            }
        }).resume()
    }
}
