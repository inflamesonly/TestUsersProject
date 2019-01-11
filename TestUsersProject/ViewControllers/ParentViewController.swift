//
//  ParentViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleColor()
    }
    
    func setTitleColor () {
        self.navigationController?.navigationBar.tintColor = BASICCOLOR
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: BASICCOLOR]
    }

}
