//
//  PreloaderClass.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/20/21.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

final class PreloaderClass {
    static let shared = PreloaderClass()
    var coverView = UIView()
    var activityLoader = UIView()
    var preloader = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: K.Colors.defaultGreen, padding: .none)
}


extension PreloaderClass {
    //Set up Preloader
    func setupPreloader(_ view: UIView, text: String) {
        view.addSubview(coverView)
        coverView.backgroundColor = UIColor(red: 0.18, green: 0.19, blue: 0.2, alpha: 0.9)
        coverView.isHidden = true
        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        activityLoader = UIView()
        coverView.addSubview(activityLoader)
        activityLoader.backgroundColor = .systemBackground
        activityLoader.layer.cornerRadius = 5
        activityLoader.addSubview(preloader)
        activityLoader.isHidden = true
        activityLoader.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.centerY.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.08)
        }
        preloader.snp.makeConstraints { (make) in
            make.centerY.equalTo(activityLoader)
            make.height.equalTo(activityLoader).multipliedBy(0.5)
            make.width.equalTo(preloader.snp.height)
            make.left.equalTo(16)
        }
        let tittleText = UILabel()
        activityLoader.addSubview(tittleText)
        tittleText.font = UIFont(name: K.Fonts.regular, size: 13)
        tittleText.textColor = .label
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        tittleText.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.25, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tittleText.snp.makeConstraints { (make) in
            make.centerY.equalTo(activityLoader)
            make.left.equalTo(preloader.snp.right).offset(16)
            make.height.equalTo(activityLoader).multipliedBy(0.7)
            make.right.equalTo(-16)
        }
    }
    
    func stopAnimation() {
        activityLoader.isHidden = true
        coverView.isHidden = true
        preloader.stopAnimating()
    }
    
    func startAnimation() {
        activityLoader.isHidden = false
        coverView.isHidden = false
        preloader.startAnimating()
    }
}
