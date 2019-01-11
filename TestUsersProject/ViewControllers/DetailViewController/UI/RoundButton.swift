//
//  RoundButton.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        self.layoutIfNeeded()
        self.setRoundCorners()
        self.createBorder()
        self.setTextColor()
    }
    
    func setRoundCorners () {
        layer.cornerRadius = self.frame.height / 2.0
        layer.masksToBounds = true
    }
    
    private func createBorder () {
        layer.borderWidth = 1
        layer.borderColor = BASICCOLOR.cgColor
    }
    
    private func setTextColor () {
        self.titleLabel?.textColor = BASICCOLOR
    }
    
}
