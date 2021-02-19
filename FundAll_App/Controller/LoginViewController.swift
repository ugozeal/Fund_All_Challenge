//
//  LoginViewController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    //MARK:- PROPERTIES
    let userDefaults = UserDefaults.standard
    var authenticateUser = AuthenticateUserReq()
    var username: String?
    var logoView = UIView()
    var paragraphStyle = NSMutableParagraphStyle()
    var createAccountButton = UIButton()
    var switchAccountButton = UIButton()
    var biometricButton = UIButton()
    var passwordButton = UIButton()
    var coverView = UIView()
    var activityLoader = UIView()
    var preloader = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: K.Colors.defaultGreen, padding: .none)

    //MARK:- OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground("login-background")
        view.backgroundColor = .black
        navigationBar()
        setupLogoView()
        setupUsernameField()
        setupBiometricButton()
        setupPasswordButton()
    }
    
    //MARK:- SETUP VIEWS
    func setupLogoView() {
        view.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.height.equalTo(view).multipliedBy(0.35)
            make.left.right.equalTo(view)
            make.centerY.equalTo(view).offset(-20)
        }
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(logoView)
            make.centerX.equalTo(logoView)
            make.height.equalTo(logoView).multipliedBy(0.4)
        }
    }
    
    func setupUsernameField() {
        let view2 = UIView()
        logoView.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.height.equalTo(logoView).multipliedBy(0.1)
            make.width.equalTo(170)
            make.centerX.equalTo(logoView)
            make.bottom.equalTo(logoView)
        }
        
        let newUserTextLabel = UILabel()
        view2.addSubview(newUserTextLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        newUserTextLabel.textAlignment = .right
        newUserTextLabel.attributedText = NSMutableAttributedString(string: "New here? ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        newUserTextLabel.textColor = .white
        newUserTextLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 15)
        newUserTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view2)
            make.left.equalTo(view2)
        }
        view.addSubview(createAccountButton)
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = UIFont(name: "FoundersGrotesk-Bold", size: 15)
        createAccountButton.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        createAccountButton.contentMode = .scaleAspectFit
        createAccountButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view2).offset(6)
            make.right.equalTo(view2)
        }
        
        let view3 = UIView()
        logoView.addSubview(view3)
        view3.snp.makeConstraints { (make) in
            make.height.equalTo(logoView).multipliedBy(0.1)
            make.width.equalTo(183)
            make.centerX.equalTo(logoView)
            make.bottom.equalTo(newUserTextLabel.snp.top).offset(-10)
        }
        
        let notAccountTextLabel = UILabel()
        view3.addSubview(notAccountTextLabel)
        notAccountTextLabel.attributedText = NSMutableAttributedString(string: "Not \(username ?? "Empty")? ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        notAccountTextLabel.textColor = .white
        notAccountTextLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 15)
        notAccountTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view3)
            make.left.equalTo(view3)
        }
        
        view.addSubview(switchAccountButton)
        switchAccountButton.setTitle("Switch Account", for: .normal)
        switchAccountButton.setTitleColor(.white, for: .normal)
        switchAccountButton.titleLabel?.font = UIFont(name: "FoundersGrotesk-Bold", size: 15)
        switchAccountButton.contentMode = .scaleAspectFit
        switchAccountButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view3).offset(1)
            make.right.equalTo(view3)
        }
        let view1 = UIView()
        logoView.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.height.equalTo(logoView).multipliedBy(0.3)
            make.width.equalTo(224)
            make.centerX.equalTo(logoView)
            make.bottom.equalTo(notAccountTextLabel.snp.top).offset(-10)
        }
        
        let usernameLabel = UILabel()
        view1.addSubview(usernameLabel)
        usernameLabel.attributedText = NSMutableAttributedString(string: "\(username ?? "Empty")'s ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont(name: "FoundersGrotesk-Bold", size: 32)
        usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view1)
            make.left.equalTo(view1)
        }
        
        let lifeStyleLabel = UILabel()
        view1.addSubview(lifeStyleLabel)
        lifeStyleLabel.attributedText = NSMutableAttributedString(string: "lifestyle", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        lifeStyleLabel.textColor = .white
        lifeStyleLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 32)
        lifeStyleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(view1)
            make.centerY.equalTo(view1)
        }
    }
    
    func setupBiometricButton() {
        let biometricLabel = UILabel()
        view.addSubview(biometricLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        biometricLabel.attributedText = NSMutableAttributedString(string: "Biometrics", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        biometricLabel.textColor = .white
        biometricLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 14)
        biometricLabel.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.bottomMargin.equalTo(view).offset(-15)
        }

        view.addSubview(biometricButton)
        biometricButton.setImage(UIImage(named: "thumbPrint"), for: .normal)
        biometricButton.layer.cornerRadius = 26.5
        biometricButton.borderWidth = 1
        biometricButton.addTarget(self, action: #selector(handleLoginButton(_:)), for: .touchUpInside)
        biometricButton.borderColor = K.Colors.defaultGreen
        biometricButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(biometricLabel)
            make.height.width.equalTo(53)
            make.bottom.equalTo(biometricLabel.snp.top).offset(-10)
        }
        
    }
    
    func setupPasswordButton() {
        let passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        passwordLabel.attributedText = NSMutableAttributedString(string: "Password", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 14)
        passwordLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.bottomMargin.equalTo(view).offset(-15)
        }

        view.addSubview(passwordButton)
        passwordButton.setImage(UIImage(named: "lock"), for: .normal)
        passwordButton.layer.cornerRadius = 26.5
        passwordButton.borderWidth = 1
        passwordButton.borderColor = K.Colors.defaultGreen
        passwordButton.addTarget(self, action: #selector(handleSignUpButton(_:)), for: .touchUpInside)
        passwordButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(passwordLabel)
            make.height.width.equalTo(53)
            make.bottom.equalTo(passwordLabel.snp.top).offset(-10)
        }
    }
    
    //MARK:- HELPERS
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func handleSignUpButton(_ sender: UIButton) {
        let destinationVc = WelcomeBackViewController()
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
    
    @objc func handleLoginButton(_ sender: UIButton) {
        let destinationVc = HomeViewController()
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
    
    @objc func handleCreateAccount() {
        let destinationVc = SignupViewController()
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
    
    //Set up Preloader
    func setupPreloader() {
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
        paragraphStyle.lineHeightMultiple = 1.0
        tittleText.attributedText = NSMutableAttributedString(string: "Signing in...", attributes: [NSAttributedString.Key.kern: 0.25, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tittleText.snp.makeConstraints { (make) in
            make.centerY.equalTo(activityLoader)
            make.height.equalTo(activityLoader).multipliedBy(0.7)
            make.left.equalTo(preloader.snp.right).offset(16)
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

extension LoginViewController {
    
}

