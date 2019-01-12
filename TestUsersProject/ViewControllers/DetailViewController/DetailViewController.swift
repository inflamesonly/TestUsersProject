//
//  DetailViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

let avatar_segue = "showUserAvatar"

protocol DetailViewControllerDelegate : class {
    func needUpdateTableView ()
    func needUpdateTableView (user : RLMUser)
}

class DetailViewController: ParentViewController {
    
    @IBOutlet weak var nameTextField: InfoTextView!
    @IBOutlet weak var lastNameTextField: InfoTextView!
    @IBOutlet weak var emailTextField: InfoTextView!
    @IBOutlet weak var avatarImageView: NewAvatarImageView!
    
    @IBOutlet weak var addButton: RoundButton!
    
    weak var delegate: DetailViewControllerDelegate?
    
    var user : RLMUser!
    var avatar : UIImage!
    var imageURL : String!
    var isNewUser : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarImageView.delegate = self
        self.checkIsNewUser()
        self.setPlaceholders()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func checkIsNewUser () {
        if isNewUser {
            self.title = "New user"
            self.addButton.setTitle("Save user", for: .normal)
            self.imageURL = ""
        } else {
            self.title = "\(user.firstName) \(user.lastName)"
            self.setUserInfo()
        }
    }
    
    private func setUserInfo () {
        self.nameTextField.infoTextField.text = self.user.firstName
        self.lastNameTextField.infoTextField.text = self.user.lastName
        self.emailTextField.infoTextField.text = self.user.email
        self.avatarImageView.image = avatar
        self.imageURL = self.user.imageUrl
    }
    
    private func setPlaceholders () {
        self.nameTextField.infoTextField.placeholder = "Enter your name"
        self.lastNameTextField.infoTextField.placeholder = "Enter your lastname"
        self.emailTextField.infoTextField.placeholder = "Enter your email"
    }
    
    @IBAction func create(_ sender: Any) {
        self.checkEmptyField()
        if self.fieldsIsValid() {
            self.createOrUpdateUser()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == avatar_segue {
            let vc = segue.destination as! AvatarsViewController
            vc.delegate = self
        }
    }
    
    func createOrUpdateUser () {
        self.isNewUser ? self.createUser() : self.updateUser()
    }
    
    private func updateUser () {
        let updatedUser = RLMUser(firstName: self.nameTextField.infoTextField.text!, lastName: self.lastNameTextField.infoTextField.text!, email: self.emailTextField.infoTextField.text!)
        self.updateUserFromServer(firstName: self.nameTextField.infoTextField.text!, lastName: self.lastNameTextField.infoTextField.text!, email: self.emailTextField.infoTextField.text!, updatedUser : updatedUser)
    }
    
    private func createUser () {
        let user = RLMUser()
        if user.findUser(email: self.emailTextField.infoTextField.text!) {
            self.presentAlertWithBackAction(withTitle: "Error", message: "User with this email is find")
        } else {
            self.saveUserFromServer(firstName: self.nameTextField.infoTextField.text!, lastName: self.lastNameTextField.infoTextField.text!, email: emailTextField.infoTextField.text!)
        }
    }
    
    private func checkEmptyField () {
        if self.nameTextField.infoTextField.text?.count == 0 {
            self.nameTextField.error()
        }
        if self.lastNameTextField.infoTextField.text?.count == 0 {
            self.lastNameTextField.error()
        }
        if self.emailTextField.infoTextField.text?.count == 0 {
            self.emailTextField.error()
        }
    }
    
    private func fieldsIsValid () -> Bool {
        if self.nameTextField.infoTextField.text!.count < 4 || self.nameTextField.infoTextField.text!.count > 16 {
            return false
        } else if self.lastNameTextField.infoTextField.text!.count < 4 || self.lastNameTextField.infoTextField.text!.count > 16 {
            return false
        } else if !emailTextField.infoTextField.text!.isValidEmail() {
            self.emailTextField.error()
            return false
        } else {
            self.nameTextField.layer.borderColor = UIColor.lightGray.cgColor
            self.lastNameTextField.layer.borderColor = UIColor.lightGray.cgColor
            self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            return true
        }
    }
    
    private func saveUserFromServer (firstName : String, lastName : String, email : String) {
        self.startActivity()
        RequestManager.sharedInstance.createUser(firstName: firstName, lastName: lastName, email: email, image_url: self.imageURL, success: { response in
            self.presentAlertWithBackAction(withTitle: "Success", message: "User save!")
            self.delegate?.needUpdateTableView()
            self.stopActivity()
        }) { errorCode in
            self.presentAlert(withTitle: "Error", message: "Server error!")
            self.stopActivity()
        }
    }
    
    private func updateUserFromServer (firstName : String, lastName : String, email : String, updatedUser : RLMUser) {
        self.startActivity()
        RequestManager.sharedInstance.updateUser(id : self.user.id, firstName: firstName, lastName: lastName, email: email, image_url: self.imageURL, success: { response in
            self.user.update(user : updatedUser)
            self.presentAlertWithBackAction(withTitle: "Success", message: "User update!")
            self.delegate?.needUpdateTableView(user: self.user)
            self.stopActivity()
        }) { errorCode in
            self.presentAlert(withTitle: "Error", message: "Server error!")
            self.stopActivity()
        }
    }
}

extension DetailViewController : AvatarsViewControllerDelegate {
    func setNewAvatar (image : UIImage, imageURL : Image) {
        self.avatar = image
        self.imageURL = imageURL.imageURL
        self.avatarImageView.image = image
    }
}

extension DetailViewController : NewAvatarImageViewDelegate {
    func avatarTapped () {
        self.performSegue(withIdentifier: avatar_segue, sender: self)
    }
}

