//
//  SignupViewController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class SignupViewController: UIViewController {
    //MARK:- PROPERTIES
    var paragraphStyle = NSMutableParagraphStyle()
    var termsAndConditionsLabel = UILabel()
    var titleLabelView = UIView()
    var scrollView = UIScrollView(frame: .zero)
    var verticalStackView = UIStackView()
    var horizontalStackView = UIStackView()
    var firstNameTextField = UITextField()
    var lastNameTextField = UITextField()
    var emailAddressTextField = UITextField()
    var phoneNumberTextField = UITextField()
    var passwordTextField = UITextField()
    var inviteCodeButton = UIButton()
    var signUpButton = UIButton()
    var loginButton = UIButton()
    var registerationModel = RegistrationReq()
    var authenticateUser = AuthenticateUserReq()
    let userDefaults = UserDefaults.standard
    var coverView = UIView()
    var activityLoader = UIView()
    var preloader = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: K.Colors.defaultGreen, padding: .none)
    
    //MARK: - OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    //MARK: - SETUP VIEWS
    func setupViews() {
        navigationBar()
        setupConditionsLabel()
        setupTitleLabel()
        setupVerticalStackView()
        setupHorizontalStackView()
        addVerticalStackViewSubViews()
        setupGetCodeButton()
        setupSignupButton()
        setupLoginButton()
        setupPreloader()
    }
    func setupConditionsLabel() {
        view.addSubview(termsAndConditionsLabel)
        termsAndConditionsLabel.numberOfLines = 0
        let fullString: NSString = K.privacyPolicy as NSString
        let firstRange = (fullString).range(of: K.privacyRange1)
        let secondRange = (fullString).range(of: K.privacyRange2)
        let attribute = NSMutableAttributedString.init(string: fullString as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: K.Colors.defaultGreen ?? UIColor(), range: firstRange)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: K.Colors.defaultGreen ?? UIColor() , range: secondRange)
        termsAndConditionsLabel.attributedText = attribute
        termsAndConditionsLabel.font = UIFont(name: K.Fonts.regular, size: 10)
        termsAndConditionsLabel.textAlignment = .center
        termsAndConditionsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottomMargin.equalTo(-20)
        }
    }
    
    func setupGetCodeButton() {
        view.addSubview(inviteCodeButton)
        inviteCodeButton.setTitle("Got invite code?", for: .normal)
        inviteCodeButton.setTitleColor(K.Colors.defaultGreen, for: .normal)
        inviteCodeButton.titleLabel?.font = UIFont(name: K.Fonts.regular, size: 13)
        inviteCodeButton.contentMode = .scaleAspectFit
        inviteCodeButton.snp.makeConstraints { (make) in
            make.top.equalTo(verticalStackView.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
        }
    }
    
    func setupSignupButton() {
        view.addSubview(signUpButton)
        signUpButton.setTitle("SIGN UP", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: K.Fonts.regular, size: 16)
        signUpButton.layer.cornerRadius = 5
        signUpButton.contentMode = .center
        signUpButton.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        signUpButton.backgroundColor = K.Colors.defaultGreen
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(inviteCodeButton.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(35)
            make.width.equalTo(view).multipliedBy(0.6)
        }
    }
    
    func setupLoginButton() {
        let view2 = UIView()
        view.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.height.equalTo(view).multipliedBy(0.03)
            make.width.equalTo(138)
            make.centerX.equalTo(view)
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
        }
        
        let memberTextLabel = UILabel()
        view2.addSubview(memberTextLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        memberTextLabel.textAlignment = .right
        memberTextLabel.attributedText = NSMutableAttributedString(string: "Already a member? ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        memberTextLabel.textColor = .systemGray
        memberTextLabel.font = UIFont(name: K.Fonts.regular, size: 13)
        memberTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view2)
            make.left.equalTo(view2)
        }
        view.addSubview(loginButton)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.label, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: K.Fonts.bold, size: 13)
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        loginButton.contentMode = .scaleAspectFit
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view2).offset(6)
            make.right.equalTo(view2)
        }
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeArea.top)
            make.height.equalTo(view).multipliedBy(0.15)
        }
        let titleLabel = UILabel()
        titleLabelView.addSubview(titleLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        titleLabel.attributedText = NSMutableAttributedString(string: "Let’s get started", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 27)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabelView).offset(20)
            make.centerY.equalTo(titleLabelView).offset(-10)
        }
        
        let subTitleLabel = UILabel()
        titleLabelView.addSubview(subTitleLabel)
        subTitleLabel.attributedText = NSMutableAttributedString(string: "Your first step toward a better financial lifestyle starts here.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        subTitleLabel.textColor = .label
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont(name: K.Fonts.regular, size: 11)
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabelView).offset(20)
            make.right.equalTo(titleLabelView).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }

    func setupHorizontalStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 20
        
        firstNameTextField.placeholder = "First name"
        firstNameTextField.borderStyle = UITextField.BorderStyle.none
        firstNameTextField.addBottomBorder()
        firstNameTextField.setupLeftImage(imageName: K.Images.person)
        firstNameTextField.keyboardType = .namePhonePad
        firstNameTextField.setValue(UIFont(name: K.Fonts.regular, size: 15.0),forKeyPath: "placeholderLabel.font")
        
        lastNameTextField.placeholder = "Last name"
        lastNameTextField.borderStyle = UITextField.BorderStyle.none
        lastNameTextField.addBottomBorder()
        lastNameTextField.setupLeftImage(imageName: K.Images.person)
        lastNameTextField.keyboardType = .namePhonePad
        lastNameTextField.setValue(UIFont(name: K.Fonts.regular, size: 15.0),forKeyPath: "placeholderLabel.font")
        
        //Add Horizontal subviews
        horizontalStackView.addArrangedSubview(firstNameTextField)
        horizontalStackView.addArrangedSubview(lastNameTextField)
    }
    
    func setupVerticalStackView() {
        view.addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(titleLabelView.snp.bottom).offset(20)
            make.height.equalTo(view).multipliedBy(0.3)
        }


        
    }
    
    func addVerticalStackViewSubViews() {
        
        emailAddressTextField.placeholder = "Email Address"
        emailAddressTextField.setValue(UIFont(name: "FoundersGrotesk-Regular", size: 15.0),forKeyPath: "placeholderLabel.font")

        emailAddressTextField.borderStyle = UITextField.BorderStyle.none
        emailAddressTextField.addBottomBorder()
        emailAddressTextField.keyboardType = .emailAddress
        emailAddressTextField.delegate = self
        emailAddressTextField.setupLeftImage(imageName: K.Images.message)
        
        phoneNumberTextField.placeholder = "Phone number"
        phoneNumberTextField.borderStyle = UITextField.BorderStyle.none
        phoneNumberTextField.addBottomBorder()
        phoneNumberTextField.setupLeftImage(imageName: K.Images.phone)
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.delegate = self
        phoneNumberTextField.setValue(UIFont(name: K.Fonts.regular, size: 15.0),forKeyPath: "placeholderLabel.font")
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.addBottomBorder()
        passwordTextField.enablePasswordToggle()
        passwordTextField.setupLeftImage(imageName: K.Images.lock)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.setValue(UIFont(name: K.Fonts.regular, size: 15.0),forKeyPath: "placeholderLabel.font")
        

        
        //Addsubviews to vertical stackview
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(emailAddressTextField)
        verticalStackView.addArrangedSubview(phoneNumberTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
    }
    
    
    //MARK: - HELPERS
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        cancelButton.tintColor = .label
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: K.Fonts.regular, size: 11)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = cancelButton
        
        let benefitsButton = UIBarButtonItem(title: "Benefits", style: .plain, target: self, action: #selector(handleBenefitsButton))
        benefitsButton.tintColor = .label
        benefitsButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: K.Fonts.regular, size: 11)!], for: UIControl.State.normal)
        navigationItem.rightBarButtonItem = benefitsButton
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
        tittleText.attributedText = NSMutableAttributedString(string: "Creating Account", attributes: [NSAttributedString.Key.kern: 0.25, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
    
    @objc func handleCancelButton() {
        
    }
    
    @objc func handleBenefitsButton() {
        
    }
    
    @objc func handleSignUpButton(_ sender: UIButton) {
        
        if emailAddressTextField.text?.isValidEmail == true {
            if passwordTextField.text?.count ?? 0 >= 6 {
                if firstNameTextField.text?.isEmpty == false && lastNameTextField.text?.isEmpty == false {
                    if phoneNumberTextField.text?.count ?? 0 == 11 {
                        startAnimation()
                        registerClient()
                    } else {
                        dismissAlert("OOPS!!!", "Phone number is not 11 digits", "okay")
                    }
                } else {
                    dismissAlert("OOPS!!!", "Seems your firstname of lastname is missing", "okay")
                }
            } else {
                dismissAlert("OOPS!!!", "Password input is less than 6 characters", "okay")
            }
        } else {
            dismissAlert("OOPS!!!", "Invalid Email Entry", "okay")
        }
    }
    
    @objc func handleLoginButton( _ sender: UIButton) {
        let destinationVc = WelcomeBackViewController()
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailAddressTextField.becomeFirstResponder()
        case emailAddressTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

extension SignupViewController {
    
    func registerClient() {
        let email = emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let firstname = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastname = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        registerationModel.email = email
        registerationModel.password = password
        registerationModel.passwordConfirmation = password
        registerationModel.firstName = firstname
        registerationModel.lastName = lastname
        NetworkClass.shared.registerNewUser(requestModel: registerationModel) { (feedback) in
            self.stopAnimation()
            if feedback.success?.status == "SUCCESS" {
                self.userDefaults.set(self.registerationModel.firstName, forKey: "firstName")
                self.authentication()
            } else {
                self.dismissAlert("OOPS!!!", "The email has already been taken.", "Okay")
            }
        } failure: { (error) in
            self.stopAnimation()
            print("Error: \(error) Occured")
            self.dismissAlert("OOPS!!!", "\(error.description)", "Okay")
        }
    }
    
    func authentication() {
        authenticateUser.email = emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        authenticateUser.password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        NetworkClass.shared.loginUser(requestModel: authenticateUser) { (feedback) in
            self.userDefaults.set(feedback.success?.user?.accessToken, forKey: "loginToken")
            self.userDefaults.set(self.authenticateUser.email, forKey: "userMail")
            self.stopAnimation()
            if feedback.success?.status ?? String() == "SUCCESS" {
                let destinationVc = LoginViewController()
                destinationVc.username = self.firstNameTextField.text
                self.alertDialog("AWESOME", "Registration successfull, click to proceed", destinationVc, "Proceed")
            } else {
                self.dismissAlert("OOPS!!!", "Check input field", "Okay")
            }
        } failure: { (error) in
            self.stopAnimation()
            self.dismissAlert("OOPS!!!", "\(error.description)", "Okay")
        }
    }
}
