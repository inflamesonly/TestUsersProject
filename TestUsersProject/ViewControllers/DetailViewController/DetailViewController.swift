//
//  DetailViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class DetailViewController: ParentViewController {
    
    @IBOutlet weak var nameTextField: InfoTextView!
    @IBOutlet weak var lastNameTextField: InfoTextView!
    @IBOutlet weak var emailTextField: InfoTextView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var user : RLMUser!
    var avatar : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setUserInfo()
        self.setPlaceholders()
        
        self.title = "\(user.firstName) \(user.lastName)"
    }
    
    private func setUserInfo () {
        self.nameTextField.infoTextField.text = self.user.firstName
        self.lastNameTextField.infoTextField.text = self.user.lastName
        self.emailTextField.infoTextField.text = self.user.email
        self.avatarImageView.image = avatar
    }
    
    private func setPlaceholders () {
        self.nameTextField.infoTextField.placeholder = "Enter your name"
        self.lastNameTextField.infoTextField.placeholder = "Enter your lastname"
        self.emailTextField.infoTextField.placeholder = "Enter your email"
    }
    
    @IBAction func create(_ sender: Any) {
        self.createUser()
    }
    
    func createUser () {
        RequestManager.sharedInstance.createUser(firstName: self.nameTextField.infoTextField.text!, lastName: self.lastNameTextField.infoTextField.text!, email: self.emailTextField.infoTextField.text!, image_url: self.user.imageUrl, success: { response in
            
        }) { errorCode in
            
        }
    }
    
}
