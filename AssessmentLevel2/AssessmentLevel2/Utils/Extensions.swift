//
//  Extensions.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import Foundation
import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: APPNAME, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // Handle button tap action here
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIView
extension UIView {
    func addCornerRadius(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

// MARK: - UIImageView
extension UIImage {
    func resizeImage(toMaxDimension maxDimension: CGFloat) -> UIImage {
        let scale = maxDimension / max(size.width, size.height)
        let newWidth = size.width * scale
        let newHeight = size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
