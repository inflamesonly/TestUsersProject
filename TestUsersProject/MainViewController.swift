//
//  ViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.sharedInstance.getUsers(success: { users in
            print("\(users)")
        }) { errorCode in
            
        }
    }


}

