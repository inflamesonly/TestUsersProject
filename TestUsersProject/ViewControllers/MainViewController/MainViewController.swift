//
//  ViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

let link_segue = "showUserDetail"

class MainViewController: ParentViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [RLMUser]()
    var selectedUser : RLMUser?
    var selectedImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.sharedInstance.getUsers(success: { users in
            self.users = users
            self.usersTableView.reloadData()
            print("\(users)")
        }) { errorCode in
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == link_segue {
            let vc = segue.destination as! DetailViewController
            vc.avatar = self.selectedImage
            vc.user = self.selectedUser
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
        performSegue(withIdentifier: link_segue, sender: self)
    }
}

