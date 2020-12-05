//
//  UIViewController + exstension.swift
//  Family
//
//  Created by Murat Merekov on 16.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
