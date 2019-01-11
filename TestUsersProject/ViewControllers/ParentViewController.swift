//
//  ParentViewController.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit
import SpringIndicator

class ParentViewController: UIViewController {
    
    var indicator : SpringIndicator!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleColor()
    }
    
    func setTitleColor () {
        self.navigationController?.navigationBar.tintColor = BASICCOLOR
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: BASICCOLOR]
    }
    
    private func addIndicator () {
        self.indicator = SpringIndicator()
        self.indicator.frame.size = CGSize(width: 100, height: 100)
        self.indicator.center = self.view.center
        self.indicator.lineColor = BASICCOLOR
        self.view.addSubview(self.indicator)
        self.indicator.start()
    }
    
    func startActivity () {
        self.addIndicator()
    }
    
    func stopActivity () {
        self.indicator.removeFromSuperview()
    }

}
