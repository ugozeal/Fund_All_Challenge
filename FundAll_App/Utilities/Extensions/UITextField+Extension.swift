//
//  UITextField+Extension.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit

extension UITextField {
    //Hide or Show password
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry{
            button.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        let cgX = CGFloat(self.frame.size.width - 25)
        button.frame = CGRect(x: cgX, y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @objc func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender)
    }
    
    func setupLeftImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .systemGray
    }
}
