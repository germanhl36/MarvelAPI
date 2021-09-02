//
//  UIViewController+Extensions.swift
//  MarvelAPI
//
//  Created by German Huerta on 01/09/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorDialog(error:Error) {
        let alert = UIAlertController(title: "Marvel", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
