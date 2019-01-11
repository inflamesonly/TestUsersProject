//
//  UserCell.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UserCell: UITableViewCell {
    
    @IBOutlet weak var bckView: BckView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var avatarImageView: AvatarView!

    func configure (user : RLMUser) {
        self.nameLabel.text = user.firstName
        self.lastNameLabel.text = user.lastName
        self.emailLabel.text = user.email
        self.updateDateLabel.text = user.updatedDate
        self.createDateLabel.text = user.createdDate
        self.checkAvatarOrPlaceholder(path: user.imageUrl)
    }
    
    func checkAvatarOrPlaceholder (path : String) {
        if path != "" {
            self.addAvatar(path: path)
        } else {
            self.avatarImageView.image = UIImage(named: "Placeholder")
        }
    }
    
    func addAvatar (path : String) {
        Alamofire.request(path).responseImage { response in
            if let image = response.result.value {
                self.avatarImageView.image = image
            }
        }
    }
}
