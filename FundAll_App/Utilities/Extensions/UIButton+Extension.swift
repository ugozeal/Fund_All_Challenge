//
//  UIButton+Extension.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit

@IBDesignable extension UIButton {
    //Add BorderWith to UIButton
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    //Add cornerRadius to UIButton
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    //Add borderColor to UIButton
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
