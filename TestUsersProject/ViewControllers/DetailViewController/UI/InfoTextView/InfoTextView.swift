//
//  InfoTextView.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class InfoTextView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var infoTextField: UITextField!
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        
    }
    
    convenience init(frame: CGRect, tittle : String) {
        self.init(frame: frame)
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "InfoTextView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        self.roundBorder()
    }
    
    func roundBorder () {
        layer.cornerRadius = self.bounds.height/2
        layer.masksToBounds = true
    }
    
    func error () {
        self.layer.borderColor = UIColor.red.cgColor
    }

}

extension InfoTextView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
