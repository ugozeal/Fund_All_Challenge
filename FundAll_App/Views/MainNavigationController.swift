//
//  MainNavigationController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import UIKit

class MainNavigationController: UIViewController {
    var firstName = ""
    var emailDetails = ""
    var avatar = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground("splash-screen")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NetworkClass.shared.loadUserData { (feedback) in
            if feedback.success?.status == "SUCCESS" {
                DispatchQueue.main.async {
                    guard let url = URL(string: feedback.success?.data?.avatar ?? "") else { return }
                    UIImage.loadImage(from: url) { (image) in
                        self.avatar.image = image
                    }
                }
                
                self.firstName = feedback.success?.data?.firstname ?? String()
                self.emailDetails = feedback.success?.data?.email ?? String()
                self.perform(#selector(self.doNecessarySegue), with: nil, afterDelay: 2)
            }
        } failure: { (error) in
            print("Error\(error)")
        }
    }
    @objc func doNecessarySegue() {
        let token = UserDefaults.standard.string(forKey: "loginToken")
        if token == nil {
            let signUpView = SignupViewController()
            signUpView.modalPresentationStyle = .fullScreen
            self.present(signUpView, animated: true, completion: nil)
        } else {
            let welcomeBackScreen = WelcomeBackViewController()
            welcomeBackScreen.emailDetails = emailDetails
            welcomeBackScreen.firstName = firstName
            welcomeBackScreen.profileImageView = avatar
            welcomeBackScreen.modalPresentationStyle = .fullScreen
            self.present(welcomeBackScreen, animated: true, completion: nil)
        }
    }
    
}
