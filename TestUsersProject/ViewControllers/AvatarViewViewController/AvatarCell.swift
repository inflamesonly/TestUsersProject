//
//  AvatarCell.swift
//  TestUsersProject
//
//  Created by macOS on 12.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    func configure (image : Image) {
        self.addAvatar(path: image.imageURL)
    }
    
    func addAvatar (path : String) {
        self.avatar.af_setImage(withURL: URL(string: path)!, placeholderImage: nil)
    }
    
}
