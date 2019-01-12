//
//  ViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

let user_segue = "showUserDetail"

class MainViewController: ParentViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [RLMUser]()
    var selectedUser : RLMUser?
    var selectedImage : UIImage?
    var isNewUser : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configMainNavigationButtons()
        self.checkInternetConnection()
    }
    
    @objc func addNewUser() {
        self.isNewUser = true
        performSegue(withIdentifier: user_segue, sender: self)
    }
    
    private func checkInternetConnection () {
        if Reachability.isConnectedToNetwork() {
            self.startActivity()
            self.getUsers()
        } else {
            self.presentAlert(withTitle: "Error", message: "Internet connection error. All users will be upload from data base.")
            self.getLocalUsers()
        }
    }
    
    func getLocalUsers () {
        let users = RLMUser.getAllUsers()
        self.users = users
        self.usersTableView.reloadData()
    }
    
    private func getUsers () {
        RequestManager.sharedInstance.getUsers(success: { users in
            self.users = users
            self.usersTableView.reloadData()
            self.stopActivity()
        }) { errorCode in
            self.presentAlert(withTitle: "Error", message: "Server error!")
            self.stopActivity()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == user_segue {
            let vc = segue.destination as! DetailViewController
            vc.avatar = self.selectedImage
            vc.user = self.selectedUser
            vc.isNewUser = self.isNewUser
            vc.delegate = self
        }
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.configure(user: user)
        cell.selectionStyle = .none
        return cell
    }
    
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        let user = users[indexPath.row]
        self.selectedImage = cell.avatarImageView.image
        self.selectedUser = user
        self.isNewUser = false
        performSegue(withIdentifier: user_segue, sender: self)
    }
}

extension MainViewController : DetailViewControllerDelegate {
    func needUpdateTableView () {
        self.getUsers()
    }
    
    func needUpdateTableView (user : RLMUser) {
        self.findUserAndReplaseHim(user: user)
        self.usersTableView.reloadData()
    }
    
    func findUserAndReplaseHim (user : RLMUser) {
        if let index = self.users.index(of: user) {
            let needUser = RLMUser().get(id: self.users[index].id)
            self.users[index] = needUser
        }
    }
}

