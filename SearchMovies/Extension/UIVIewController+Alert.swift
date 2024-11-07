//
//  UIVIewController+Alert.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/7/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(error: String, isDismissAction: Bool = false) {
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            if isDismissAction {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
