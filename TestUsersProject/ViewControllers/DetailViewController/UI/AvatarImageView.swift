//
//  AvatarImageView.swift
//  TestUsersProject
//
//  Created by macOS on 12.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

protocol NewAvatarImageViewDelegate : class {
    func avatarTapped ()
}

class NewAvatarImageView: AvatarView {
    
    weak var delegate: NewAvatarImageViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: .zero)
    }
    private func commonInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    @objc func imageTapped () {
        self.delegate?.avatarTapped()
    }
}
