//
//  ViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [RLMUser]()
    var selectedUser : RLMUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.sharedInstance.getUsers(success: { users in
            self.users = users
            self.usersTableView.reloadData()
            print("\(users)")
        }) { errorCode in
            
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
//        cell.bckView.se

//        let feed = feeds[indexPath.row]
//        self.selectedFeed = feed
//        performSegue(withIdentifier: link_segue, sender: self)
    }
}

