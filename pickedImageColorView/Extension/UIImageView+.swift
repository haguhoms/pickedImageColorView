//
//  UIImageView+.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/08.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {

    func setImage(with urlString: String?, placeholder: UIImage?, completed: ((Result<ImageResponse, ImagePipeline.Error>) -> Void)? = nil) {
        self.image = placeholder

        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return
        }

        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
        let loadingOptions = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.2))
        loadImage(with: url, options: loadingOptions, into: self, progress: nil, completion: { result in
            completed?(result)
        })
    }
}
