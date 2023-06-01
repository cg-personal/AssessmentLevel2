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
