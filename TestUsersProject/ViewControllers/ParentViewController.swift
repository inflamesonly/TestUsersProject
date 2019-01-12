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
    var blackView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleColor()
    }
    
    func setTitleColor () {
        self.navigationController?.navigationBar.tintColor = BASICCOLOR
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: BASICCOLOR]
    }
    
    func configMainNavigationButtons () {
        let itemOne = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MainViewController.addNewUser))
        self.navigationItem.rightBarButtonItems = [itemOne]
    }
    
    private func addIndicator () {
        self.indicator = SpringIndicator()
        self.indicator.frame.size = CGSize(width: 100, height: 100)
        self.indicator.center = self.view.center
        self.indicator.lineColor = BASICCOLOR
        self.navigationController?.view.addSubview(self.indicator)
        self.indicator.start()
    }
    
    private func addBlackView () {
        self.blackView = UIView()
        self.blackView.frame = self.view.frame
        self.blackView.backgroundColor = UIColor.black
        self.blackView.alpha = 0.5
        self.navigationController?.view.addSubview(self.blackView)
    }
    
    func startActivity () {
        self.addBlackView()
        self.addIndicator()
    }
    
    func stopActivity () {
        self.indicator.removeFromSuperview()
        self.blackView.removeFromSuperview()
    }

}
