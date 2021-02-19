//
//  PickCardViewController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import UIKit
import SnapKit

class PickCardViewController: UIViewController {
    //MARK: - Properties
    var paragraphStyle = NSMutableParagraphStyle()
    var topView = UIView()
    var cardScrollView = UIScrollView(frame: .zero)
    var pickCardTableView = UITableView()
    var continueButton = UIButton()
    var coverView = UIView()
    var activityLoader = UIView()
    let delay = 3
    var referButton = UIButton()
    let profileImageView = UIImageView()
    
    //MARK:- UITableViewDataSource
    private var pickCardCells = CardActivityModel.pickCardCells()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkClass.shared.loadUserData { (feedback) in
            if feedback.success?.status == "SUCCESS" {
                DispatchQueue.main.async {
                    guard let url = URL(string: feedback.success?.data?.avatar ?? "") else { return }
                    UIImage.loadImage(from: url) { (image) in
                        self.profileImageView.image = image
                    }
                }
            }
        } failure: { (error) in
            print("Error\(error)")
        }
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Set up Views
    func setupViews() {
        navigationBar()
        setupTopView()
        setupCardScrollView()
        setupButton()
        setupTableView()
        setupPopup()
    }
    func setupTopView() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.13)
            make.topMargin.equalTo(view)
        }
        let titleLabel = UILabel()
        topView.addSubview(titleLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        titleLabel.attributedText = NSMutableAttributedString(string: "Your New Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 27)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView)
            make.centerY.equalTo(topView).offset(20)
        }
        
        topView.addSubview(profileImageView)
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 15
        profileImageView.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(50)
            make.width.equalTo(40)
        }
    }
    
    func setupCardScrollView() {
        view.addSubview(cardScrollView)
        cardScrollView.frame = cardScrollView.bounds
        cardScrollView.showsHorizontalScrollIndicator = false
        cardScrollView.autoresizingMask = .flexibleWidth
        cardScrollView.contentSize = CGSize(width: view.frame.width + 100, height: 205)
        cardScrollView.bounces = true
        cardScrollView.contentOffset = CGPoint(x:0, y:150)
        cardScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(30)
            make.width.equalTo(view).offset(20)
            make.height.equalTo(view).multipliedBy(0.4)
        }
        
        let card1 = UIControl()
        cardScrollView.addSubview(card1)
        card1.backgroundColor = .systemGray
        card1.clipsToBounds = true
        card1.layer.cornerRadius = 12
        card1.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardScrollView)
            make.left.equalTo(cardScrollView).offset(15)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(view).multipliedBy(0.35)
        }

        let card1Text = UILabel()
        card1.addSubview(card1Text)
        card1Text.attributedText = NSMutableAttributedString(string: "Fundall Lifestyle Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        card1Text.textColor = .black
        card1.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        card1Text.font = UIFont(name: K.Fonts.medium, size: 10)
        card1Text.snp.makeConstraints { (make) in
            make.top.equalTo(card1).offset(15)
            make.left.equalTo(card1).offset(11)
        }
        
        let card2 = UIControl()
        cardScrollView.addSubview(card2)
        card2.backgroundColor = .systemGray
        card2.clipsToBounds = true
        card2.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        card2.layer.cornerRadius = 12
        card2.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardScrollView)
            make.left.equalTo(card1.snp.right).offset(15)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(view).multipliedBy(0.35)
        }

        let card2Text = UILabel()
        card2.addSubview(card2Text)
        card2Text.attributedText = NSMutableAttributedString(string: "Fundall Lifestyle Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        card2Text.textColor = .black
        card2Text.font = UIFont(name: K.Fonts.medium, size: 10)
        card2Text.snp.makeConstraints { (make) in
            make.top.equalTo(card2).offset(15)
            make.left.equalTo(card2).offset(11)
        }
        
        let card3 = UIControl()
        cardScrollView.addSubview(card3)
        card3.backgroundColor = .systemGray
        card3.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        card3.clipsToBounds = true
        card3.layer.cornerRadius = 12
        card3.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardScrollView)
            make.left.equalTo(card2.snp.right).offset(15)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(view).multipliedBy(0.35)
        }
        
        let card3Text = UILabel()
        card3.addSubview(card3Text)
        card3Text.attributedText = NSMutableAttributedString(string: "Fundall Lifestyle Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        card3Text.textColor = .black
        card3Text.font = UIFont(name: K.Fonts.medium, size: 10)
        card3Text.snp.makeConstraints { (make) in
            make.top.equalTo(card3).offset(15)
            make.left.equalTo(card3).offset(11)
        }
    }
    
    func setupTableView() {
        let tableTitle = UILabel()
        view.addSubview(tableTitle)
        paragraphStyle.lineHeightMultiple = 1.1
        tableTitle.attributedText = NSMutableAttributedString(string: "Pick a Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tableTitle.textColor = .black
        tableTitle.font = UIFont(name: K.Fonts.medium, size: 27)
        tableTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cardScrollView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        //Setup table view
        view.addSubview(pickCardTableView)
        //Set Delegate
        pickCardTableView.dataSource = self
        pickCardTableView.delegate = self
        //Set the height
        pickCardTableView.rowHeight = 80
        pickCardTableView.backgroundColor = .white
        pickCardTableView.separatorColor = .systemGray
        pickCardTableView.register(PickCardViewCell.self, forCellReuseIdentifier: K.reuseIdentifier)
        //Set Constraints
        pickCardTableView.snp.makeConstraints { (make) in
            make.top.equalTo(tableTitle.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(continueButton.snp.top).offset(-10)
        }
    }
    
    func setupButton() {
        view.addSubview(continueButton)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.titleLabel?.font = UIFont(name: K.Fonts.medium, size: 16)
        continueButton.layer.cornerRadius = 5
        continueButton.contentMode = .center
        continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        continueButton.backgroundColor = K.Colors.defaultGreen
        continueButton.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(view).offset(-15)
            make.height.equalTo(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    

    //MARK:- HELPERS
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let cancelButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancelButton))
        cancelButton.tintColor = .black
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: K.Fonts.regular, size: 11)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupPopup() {
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
        activityLoader.isHidden = true
        activityLoader.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.centerY.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.35)
        }
        let tittleText = UILabel()
        activityLoader.addSubview(tittleText)
        tittleText.font = UIFont(name: K.Fonts.medium, size: 17)
        tittleText.textColor = .label
        paragraphStyle.lineHeightMultiple = 1.0
        tittleText.contentMode = .center
        tittleText.attributedText = NSMutableAttributedString(string: "Yippeee! \nCard Request Successful. \nWelcome to tomorrow", attributes: [NSAttributedString.Key.kern: 0.25, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tittleText.numberOfLines = 0
        tittleText.snp.makeConstraints { (make) in
            make.centerY.equalTo(activityLoader).offset(-10)
            make.centerX.equalTo(activityLoader)
            make.width.equalTo(activityLoader).multipliedBy(0.7)
        }
        
        view.addSubview(referButton)
        referButton.isHidden = true
        referButton.setTitle("REFER YOUR FRIENDS & EARN", for: .normal)
        referButton.setTitleColor(.black, for: .normal)
        referButton.titleLabel?.font = UIFont(name: K.Fonts.medium, size: 13)
        referButton.layer.cornerRadius = 5
        referButton.contentMode = .center
        referButton.backgroundColor = K.Colors.defaultGreen
        referButton.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(activityLoader).offset(-15)
            make.height.equalTo(40)
            make.left.equalTo(activityLoader).offset(20)
            make.right.equalTo(activityLoader).offset(-20)
        }
        
        let circleShapeImageView = UIView()
        circleShapeImageView.clipsToBounds = true
        circleShapeImageView.backgroundColor = K.Colors.defaultGreen
        activityLoader.addSubview(circleShapeImageView)
        circleShapeImageView.layer.cornerRadius = 10
        circleShapeImageView.snp.makeConstraints { (make) in
            make.right.equalTo(activityLoader).offset(-20)
            make.height.width.equalTo(20)
            make.top.equalTo(activityLoader).offset(20)
        }
        
    }
    
    func stopAnimation() {
        activityLoader.isHidden = true
        coverView.isHidden = true
        referButton.isHidden = true
    }
    
    func startAnimation() {
        activityLoader.isHidden = false
        coverView.isHidden = false
        referButton.isHidden = false
    }
    
    @objc func animateView(_ view1: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut) {
            view1.backgroundColor = .red
        } completion: { (finished) in
            print("Animation Finished: \(finished)")
            view1.backgroundColor = .systemGray
        }
    }
    
    @objc func handleCancelButton() {
        let destinationVc = HomeViewController()
        destinationVc.profileImageView = profileImageView
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true, completion: nil)
    }
    
    @objc func handleContinueButton() {
        startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.stopAnimation()
            let destinationVc = HomeViewController()
            destinationVc.modalPresentationStyle = .fullScreen
            self.present(destinationVc, animated: true)
        }
    }

}

extension PickCardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickCardCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickCardTableView.dequeueReusableCell(withIdentifier: K.reuseIdentifier, for: indexPath) as? PickCardViewCell
        let cards = pickCardCells[indexPath.row]
        cell?.amountLabel.text = cards.time
        cell?.cellImageView.image = cards.featuredImage
        cell?.titleLabel.text = cards.title
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell?.selectedBackgroundView = bgColorView
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
