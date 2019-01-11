//
//  BckView.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

private let SELECTEDCOLOR = UIColor(red:251/255, green:253/255, blue:254/255, alpha: 1)

class BckView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            updateCornerRadius()
        }
    }
    
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
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(layer.shadowRadius)
        }
        set {
            layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = borderRadius
    }
    
    func setSelected () {
        self.backgroundColor = SELECTEDCOLOR
    }
    
    func setDeselected () {
        self.backgroundColor = UIColor.white
    }
}
