//
//  UIView+Extension.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import  SnapKit

@IBDesignable extension UIView {
    //Add borderwidth to UIView
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    //Add cornerRadius to UIView
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    //Add borderColor to UIView
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    //Constraint To SafeArea
    var safeArea : ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
    
    //Add Shadow to View
    func setupOtherViewShadow(_ view : UIView, scale: Bool = true) {
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addBackground(_ imageName: String) {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imageName)
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    

}

public extension UIView {
    func addBottomBorder(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = K.Colors.defaultGreen
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(6)
        }
    }
    
    func addViewBorderColor() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = .systemGray
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self.snp.top)
        }
    }
}
