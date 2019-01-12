//
//  AlertViewExt.swift
//  RssTestProject
//
//  Created by macOS on 09.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertWithBackAction(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            if let topController = UIApplication.topViewController() {
                topController.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
