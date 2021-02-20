//
//  WelcomeBackViewController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class WelcomeBackViewController: UIViewController {
    //MARK: - Properties
    var paragraphStyle = NSMutableParagraphStyle()
    var authenticateUser = AuthenticateUserReq()
    var titleLabelView = UIView()
    var profileImageView = UIImageView()
    var userDetailsView = UIView()
    var passwordTextField = UITextField()
    let createAccountView = UIView()
    var createAccountButton = UIButton()
    var loginButton = UIButton()
    let userDefaults = UserDefaults.standard
    var emailDetails: String?
    var defaultEmail = ""
    var firstName: String?
    let delay = 3

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupAllViews()
        defaultEmail = UserDefaults.standard.string(forKey: "userMail") ?? String()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NetworkClass.shared.loadUserData { (feedback) in
            if feedback.success?.status == "SUCCESS" {
                DispatchQueue.main.async {
                    guard let url = URL(string: feedback.success?.data?.avatar ?? "") else { return }
                    UIImage.loadImage(from: url) { (image) in
                        
                        if image != nil {
                            self.profileImageView.image = image
                        } else {
                            self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill.badge.exclamationmark", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(K.Colors.defaultGreen ?? UIColor(), renderingMode: .alwaysOriginal)
                        }
                    }
                    self.firstName = feedback.success?.data?.firstname ?? String()
                    self.emailDetails = feedback.success?.data?.email ?? String()
                }
            }
        } failure: { (error) in
            print("Error\(error)")
        }
    }
    
    //MARK: - Setup Views
    func setupAllViews() {
        navigationBar()
        setupTitleLabel()
        setupProfileImage()
        setupUserDetailsView()
        setupPasswordField()
        setupLoginButton()
        setUpCreateAccountView()
        PreloaderClass.shared.setupPreloader(view, text: "Signing in ...")
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.centerX.right.equalTo(view)
            make.top.equalTo(view.safeArea.top).offset(15)
            make.height.equalTo(view).multipliedBy(0.08)
        }
        let titleLabel = UILabel()
        titleLabelView.addSubview(titleLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        titleLabel.attributedText = NSMutableAttributedString(string: "Welcome back!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 27)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabelView)
            make.centerY.equalTo(titleLabelView)
        }
    }
    
    func setupProfileImage() {
        view.addSubview(profileImageView)
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill.badge.exclamationmark", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(K.Colors.defaultGreen ?? UIColor(), renderingMode: .alwaysOriginal)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 72
        profileImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(144)
            make.centerX.equalTo(view)
            make.top.equalTo(titleLabelView.snp.bottom).offset(20)
        }
    }
    
    func setupUserDetailsView() {
        view.addSubview(userDetailsView)
        userDetailsView.snp.makeConstraints { (make) in
            make.centerX.right.equalTo(view)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.height.equalTo(view).multipliedBy(0.08)
        }
        
        let titleLabel = UILabel()
        userDetailsView.addSubview(titleLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        titleLabel.attributedText = NSMutableAttributedString(string: "We miss you, \(firstName ?? "")", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 27)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(userDetailsView)
            make.top.equalTo(userDetailsView)
        }
        
        let subTitleLabel = UILabel()
        userDetailsView.addSubview(subTitleLabel)
        subTitleLabel.attributedText = NSMutableAttributedString(string: emailDetails ?? defaultEmail, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        subTitleLabel.textColor = .label
        subTitleLabel.font = UIFont(name: K.Fonts.regularItalics, size: 15)
        subTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(userDetailsView)
            make.bottom.equalTo(userDetailsView)
        }
    }
    
    func setupPasswordField() {
        view.addSubview(passwordTextField)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.addBottomBorder()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        passwordTextField.textAlignment = .center
        passwordTextField.setValue(UIFont(name: K.Fonts.regular, size: 15.0),forKeyPath: "placeholderLabel.font")
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        passwordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(view).multipliedBy(0.7)
            make.centerX.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.08)
            make.top.equalTo(userDetailsView.snp.bottom).offset(20)
        }
    }
    
    func setUpCreateAccountView() {
        view.addSubview(createAccountView)
        createAccountView.snp.makeConstraints { (make) in
            make.height.equalTo(view).multipliedBy(0.03)
            make.width.equalTo(170)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
        
        let newUserTextLabel = UILabel()
        createAccountView.addSubview(newUserTextLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        newUserTextLabel.textAlignment = .right
        newUserTextLabel.attributedText = NSMutableAttributedString(string: "New here? ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        newUserTextLabel.textColor = .systemGray
        newUserTextLabel.font = UIFont(name: "FoundersGrotesk-Regular", size: 15)
        newUserTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(createAccountView)
            make.left.equalTo(createAccountView)
        }
        view.addSubview(createAccountButton)
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.titleLabel?.font = UIFont(name: "FoundersGrotesk-Bold", size: 15)
        createAccountButton.addTarget(self, action: #selector(handleCreatAccountButton), for: .touchUpInside)
        createAccountButton.contentMode = .scaleAspectFit
        createAccountButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(createAccountView).offset(6)
            make.right.equalTo(createAccountView)
        }
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: K.Fonts.medium, size: 16)
        loginButton.layer.cornerRadius = 5
        loginButton.contentMode = .center
        loginButton.backgroundColor = K.Colors.defaultGreen
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(70)
            make.height.equalTo(35)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    

    //MARK: - HELPERS
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        cancelButton.tintColor = .label
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: K.Fonts.regular, size: 11)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    @objc func handleCancelButton() {
        
    }
    
    @objc func handleCreatAccountButton() {
        let destinationVc = SignupViewController()
        self.alertDialog("WELCOME!!!", "To create your free acount, click to proceed", destinationVc, "Proceed")
    }
    
    @objc func handleLoginButton() {
        if passwordTextField.text?.isEmpty == false {
            PreloaderClass.shared.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                self.authentication()
            }
        } else {
            dismissAlert("OOPS!!!", "Input field is empty", "Okay")
        }
    }

}

extension WelcomeBackViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension WelcomeBackViewController {
    func authentication() {
        authenticateUser.email = emailDetails
        authenticateUser.password = passwordTextField.text
        NetworkClass.shared.loginUser(requestModel: authenticateUser) { (feedback) in
            self.userDefaults.set(feedback.success?.user?.accessToken, forKey: "loginToken")
            PreloaderClass.shared.stopAnimation()
            if feedback.success?.status ?? String() == "SUCCESS" {
                let destinationVc = HomeViewController()
                self.alertDialog("AWESOME", "Welcome back \(self.firstName ?? "")", destinationVc, "Proceed")
            } else {
                self.dismissAlert("OOPS!!!", "Check input field", "Okay")
            }
        } failure: { (error) in
            PreloaderClass.shared.stopAnimation()
            self.dismissAlert("OOPS!!!", "\(error.description)", "Okay")
        }
    }
}

