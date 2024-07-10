//
//  UIViewController+Extension.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showDefaultAlertPopUp(with message: String, title: String, completionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
