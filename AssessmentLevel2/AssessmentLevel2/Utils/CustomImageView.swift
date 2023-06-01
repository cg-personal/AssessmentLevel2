//
//  CustomImageView.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    
    func loadImage(urlString: String) {
        self.image = nil
        if let task = task {
            task.cancel()
        }
        let url = URL(string: urlString)
        guard let url else { return }
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let newImage = UIImage(data: data)?.resizeImage(toMaxDimension: 100) else {
                print("Cannot load image from url: \(url)")
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.image = newImage
            }
        }
        task.resume()
    }
}
