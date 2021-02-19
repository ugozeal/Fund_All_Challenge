//
//  UIViewController+Extension.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit

extension UIViewController {
    //Dismiss uiviewcontroller alert
    func dismissAlert(_ title: String, _ message: String, _ action: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Dismiss UIViewController Alert with a segue
    func alertDialog(_ title: String, _ message: String, _ destination: UIViewController, _ action: String) {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: action, style: .default, handler: { (action) in
            alertDialog.dismiss(animated: true, completion: nil)
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: true, completion: nil)
        }))
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    //Add Image to textfield
    func addImageToTextField(image: String) -> UIView {
        let image = UIImage(systemName: image, withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        myView.addSubview(imageView)
        myView.contentMode = .center
        return myView
    }

}
