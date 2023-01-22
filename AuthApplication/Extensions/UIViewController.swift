//
//  UIViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 22.01.2023.
//

import UIKit

public extension UIViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
