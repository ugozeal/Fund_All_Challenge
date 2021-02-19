//
//  HomeViewController.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import SnapKit
import MobileCoreServices
import Alamofire
import SwiftUI

class HomeViewController: UIViewController {
    //MARK:- Properties
    var paragraphStyle = NSMutableParagraphStyle()
    var scrollView = UIScrollView(frame: .zero)
    var exitButton = UIButton()
    var analyticsView = UIView()
    var topView = UIView()
    var activityView = UIView()
    var cardsView = UIView()
    var cardTitle = UILabel()
    var cardScrollView = UIScrollView(frame: .zero)
    var cardTableView = UITableView()
    var uploadImageButton = UIButton()
    var currentImage: UIImage?
    var uploadImage = UpDateAvatar()
    @State var  profileImageView = UIImageView()
    
    //MARK:- UITableViewDataSource
    private var cardCells = CardActivityModel.createCardActivityCells()
    
    //MARK:- Overrides
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
        view.backgroundColor = K.Colors.homeBgColor
        navigationBar()
        setupScrollView()
        setupTopView()
        setupAnalyticsView()
        setupLunchView()
        setupCardsView()
        setupCardScrollView()
        setupCardTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Setup Views
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.frame = scrollView.bounds
        scrollView.backgroundColor = K.Colors.homeBgColor
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 900)
        scrollView.bounces = true
        scrollView.contentOffset = CGPoint(x:250, y:0)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height).multipliedBy(0.1)
            make.bottom.equalTo(view)
        }
    }
    func setupTopView () {
        scrollView.addSubview(topView)
        topView.backgroundColor = K.Colors.thickGreen
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.clipsToBounds = true
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(-50)
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.5)
        }
        let topViewImageView = UIImageView()
        scrollView.addSubview(topViewImageView)
        topViewImageView.image = UIImage(named:"home-image1")
        topViewImageView.contentMode = .scaleToFill
        topViewImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.top).offset(2)
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        let titleLabel = UILabel()
        topView.addSubview(titleLabel)
        paragraphStyle.lineHeightMultiple = 1.1
        titleLabel.attributedText = NSMutableAttributedString(string: "Fundall e-Wallet", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 27)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView)
            make.topMargin.equalTo(topView).offset(70)
        }
        view.addSubview(exitButton)
        exitButton.setImage(UIImage(named: "home-exit"), for: .normal)
        exitButton.addTarget(self, action: #selector(handleExitButton), for: .touchUpInside)
        exitButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.centerY.equalTo(titleLabel)
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
        view.addSubview(uploadImageButton)
        uploadImageButton.setImage(UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        uploadImageButton.addTarget(self, action: #selector(importPicture), for: .touchUpInside)
        uploadImageButton.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(profileImageView)
        }
        let totalBalanceView = UIView()
        topView.addSubview(totalBalanceView)
        totalBalanceView.snp.makeConstraints { (make) in
            make.centerY.equalTo(topView).offset(20)
            make.centerX.equalTo(topView)
            make.width.equalTo(topView).multipliedBy(0.6)
            make.height.equalTo(70)
        }
        
        let totalBalanceText = UILabel()
        totalBalanceView.addSubview(totalBalanceText)
        totalBalanceText.attributedText = NSMutableAttributedString(string: "Total Balance", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        totalBalanceText.textColor = .white
        totalBalanceText.font = UIFont(name: K.Fonts.regular, size: 17)
        totalBalanceText.snp.makeConstraints { (make) in
            make.top.equalTo(totalBalanceView)
            make.centerX.equalTo(totalBalanceView)
        }
        
        let amountTextLabel = UILabel()
        totalBalanceView.addSubview(amountTextLabel)
        amountTextLabel.attributedText = NSMutableAttributedString(string: "₦12,634.37", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        amountTextLabel.textColor = .white
        amountTextLabel.font = UIFont(name: K.Fonts.regular, size: 32)
        amountTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(totalBalanceView)
            make.centerX.equalTo(totalBalanceView)
        }
        let bottomView = UIView()
        topView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(topView).offset(-20)
            make.centerX.equalTo(topView)
            make.width.equalTo(topView).multipliedBy(0.8)
            make.height.equalTo(45)
        }
        let incomeText = UILabel()
        bottomView.addSubview(incomeText)
        incomeText.attributedText = NSMutableAttributedString(string: "Income", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        incomeText.textColor = .white
        incomeText.font = UIFont(name: K.Fonts.regular, size: 13)
        incomeText.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView)
            make.left.equalTo(bottomView)
        }
        
        let incomeTextLabel = UILabel()
        bottomView.addSubview(incomeTextLabel)
        incomeTextLabel.attributedText = NSMutableAttributedString(string: "₦12,634.37", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        incomeTextLabel.textColor = .white
        incomeTextLabel.font = UIFont(name: K.Fonts.regular, size: 18)
        incomeTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomView)
            make.left.equalTo(bottomView)
        }
        let spentTextLabel = UILabel()
        bottomView.addSubview(spentTextLabel)
        spentTextLabel.attributedText = NSMutableAttributedString(string: "₦12,634.37", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        spentTextLabel.textColor = .white
        spentTextLabel.font = UIFont(name: K.Fonts.regular, size: 18)
        spentTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomView)
            make.right.equalTo(bottomView)
        }
        
        let spentText = UILabel()
        bottomView.addSubview(spentText)
        spentText.attributedText = NSMutableAttributedString(string: "Spent", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        spentText.textColor = .white
        spentText.font = UIFont(name: K.Fonts.regular, size: 13)
        spentText.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView)
            make.left.equalTo(spentTextLabel.snp.left)
        }
    }
    
    func setupAnalyticsView() {
        scrollView.addSubview(analyticsView)
        analyticsView.snp.makeConstraints { (make) in
            make.height.equalTo(70)
            make.width.equalTo(view).multipliedBy(0.6)
            make.centerX.equalTo(view)
            make.top.equalTo(topView.snp.bottom).offset(20)
        }
        
        let cardText = UILabel()
        analyticsView.addSubview(cardText)
        paragraphStyle.lineHeightMultiple = 1.0
        cardText.attributedText = NSMutableAttributedString(string: "Request Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        cardText.textColor = K.Colors.thickGreen
        cardText.font = UIFont(name: K.Fonts.regular, size: 12)
        cardText.snp.makeConstraints { (make) in
            make.bottom.equalTo(analyticsView)
            make.left.equalTo(analyticsView).offset(5)
        }
        let cardImageView = UIButton()
        cardImageView.setImage(UIImage(named: "budget"), for: .normal)
        view.addSubview(cardImageView)
        cardImageView.clipsToBounds = true
        cardImageView.addTarget(self, action: #selector(requestCardButton), for: .touchUpInside)
        cardImageView.backgroundColor = .white
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.cornerRadius = 25
        cardImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardText)
            make.top.equalTo(analyticsView)
            make.height.width.equalTo(50)
        }
        
        let analyticsText = UILabel()
        analyticsView.addSubview(analyticsText)
        analyticsText.attributedText = NSMutableAttributedString(string: "Analytics", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        analyticsText.textColor = K.Colors.thickGreen
        analyticsText.font = UIFont(name: K.Fonts.regular, size: 12)
        analyticsText.snp.makeConstraints { (make) in
            make.bottom.equalTo(analyticsView)
            make.right.equalTo(analyticsView).offset(-5)
        }
        let analyticsImageView = UIImageView()
        analyticsImageView.image = UIImage(named: "analytics")
        analyticsView.addSubview(analyticsImageView)
        analyticsImageView.clipsToBounds = true
        analyticsImageView.backgroundColor = .white
        analyticsImageView.contentMode = .scaleAspectFit
        analyticsImageView.layer.cornerRadius = 25
        analyticsImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(analyticsText)
            make.top.equalTo(analyticsView)
            make.height.width.equalTo(50)
        }
    }

    //Lunch and Car fuel view
    func setupLunchView() {
        scrollView.addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(analyticsView.snp.bottom).offset(20)
            make.height.equalTo(360)
        }
        
        let mainLunchView = UIView()
        activityView.addSubview(mainLunchView)
        mainLunchView.backgroundColor = .white
        mainLunchView.layer.cornerRadius = 10
        mainLunchView.snp.makeConstraints { (make) in
            make.left.equalTo(activityView).offset(20)
            make.right.equalTo(activityView).offset(-20)
            make.top.equalTo(activityView)
            make.height.equalTo(175)
        }
        
        let carFuelView = UIView()
        activityView.addSubview(carFuelView)
        carFuelView.backgroundColor = .white
        carFuelView.layer.cornerRadius = 10
        carFuelView.snp.makeConstraints { (make) in
            make.left.equalTo(activityView).offset(20)
            make.right.equalTo(activityView).offset(-20)
            make.top.equalTo(mainLunchView.snp.bottom).offset(10)
            make.height.equalTo(175)
        }
        
        let lunchView1 = UIView()
        mainLunchView.addSubview(lunchView1)
        lunchView1.snp.makeConstraints { (make) in
            make.top.equalTo(mainLunchView)
            make.left.right.equalTo(mainLunchView)
            make.height.equalTo(mainLunchView).multipliedBy(0.3)
        }
        let burgerImageView = UIImageView()
        lunchView1.addSubview(burgerImageView)
        burgerImageView.image = UIImage(named: "burger")
        burgerImageView.clipsToBounds = true
        burgerImageView.snp.makeConstraints { (make) in
            make.left.equalTo(lunchView1).offset(18)
            make.centerY.equalTo(lunchView1)
            make.height.width.equalTo(lunchView1.snp.height).multipliedBy(0.4)
        }
        let lunchText = UILabel()
        lunchView1.addSubview(lunchText)
        paragraphStyle.lineHeightMultiple = 1.0
        lunchText.attributedText = NSMutableAttributedString(string: "Lunch & Dinner", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        lunchText.textColor = .black
        lunchText.font = UIFont(name: K.Fonts.light, size: 14)
        lunchText.snp.makeConstraints { (make) in
            make.centerY.equalTo(burgerImageView).offset(2)
            make.left.equalTo(burgerImageView.snp.right).offset(11)
        }

        let lunchAmountText = UILabel()
        lunchView1.addSubview(lunchAmountText)
        lunchAmountText.attributedText = NSMutableAttributedString(string: "$52/day", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        lunchAmountText.textColor = .black
        lunchAmountText.font = UIFont(name: K.Fonts.light, size: 14)
        lunchAmountText.snp.makeConstraints { (make) in
            make.centerY.equalTo(burgerImageView).offset(2)
            make.right.equalTo(lunchView1).offset(-15)
        }

        let lunchView2 = UIView()
        mainLunchView.addSubview(lunchView2)
        lunchView2.addViewBorderColor()
        lunchView2.snp.makeConstraints { (make) in
            make.bottom.equalTo(mainLunchView)
            make.left.right.equalTo(mainLunchView)
            make.height.equalTo(mainLunchView).multipliedBy(0.3)
        }
        let checkImageView = UIImageView()
        lunchView2.addSubview(checkImageView)
        checkImageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(K.Colors.thickGreen ?? UIColor(), renderingMode: .alwaysOriginal)
        checkImageView.clipsToBounds = true
        checkImageView.snp.makeConstraints { (make) in
            make.left.equalTo(lunchView2).offset(18)
            make.centerY.equalTo(lunchView2)
            make.height.width.equalTo(lunchView2.snp.height).multipliedBy(0.4)
        }
        let lunchText2 = UILabel()
        lunchView2.addSubview(lunchText2)
        paragraphStyle.lineHeightMultiple = 1.0
        lunchText2.attributedText = NSMutableAttributedString(string: "Your food spending is still on track", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        lunchText2.textColor = .systemGray
        lunchText2.font = UIFont(name: K.Fonts.light, size: 14)
        lunchText2.snp.makeConstraints { (make) in
            make.centerY.equalTo(checkImageView).offset(2)
            make.left.equalTo(checkImageView.snp.right).offset(10)
        }
        let lunchRangeView1 = UIView()
        mainLunchView.addSubview(lunchRangeView1)
        lunchRangeView1.backgroundColor = K.Colors.rangeColor
        lunchRangeView1.clipsToBounds = true
        lunchRangeView1.layer.cornerRadius = 22
        lunchRangeView1.snp.makeConstraints { (make) in
            make.centerY.equalTo(mainLunchView).offset(-7)
            make.right.equalTo(mainLunchView).offset(-15)
            make.left.equalTo(mainLunchView).offset(15)
            make.height.equalTo(mainLunchView).multipliedBy(0.25)
        }
        let lunchRangeView2 = UIView()
        lunchRangeView1.addSubview(lunchRangeView2)
        lunchRangeView2.backgroundColor = K.Colors.thickGreen
        lunchRangeView2.layer.cornerRadius = 22
        lunchRangeView2.snp.makeConstraints { (make) in
            make.centerY.equalTo(lunchRangeView1)
            make.left.equalTo(lunchRangeView1)
            make.width.equalTo(lunchRangeView1).multipliedBy(0.5)
            make.height.equalTo(lunchRangeView1)
        }

        let rangeTwoText = UILabel()
        lunchRangeView2.addSubview(rangeTwoText)
        rangeTwoText.attributedText = NSMutableAttributedString(string: "$450", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        rangeTwoText.textColor = .white
        rangeTwoText.font = UIFont(name: K.Fonts.light, size: 14)
        rangeTwoText.snp.makeConstraints { (make) in
            make.centerY.equalTo(lunchRangeView2).offset(2)
            make.left.equalTo(lunchRangeView2).offset(18)
        }

        let rangeOneText = UILabel()
        lunchRangeView1.addSubview(rangeOneText)
        rangeOneText.attributedText = NSMutableAttributedString(string: "$900", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        rangeOneText.textColor = .systemGray
        rangeOneText.font = UIFont(name: K.Fonts.light, size: 14)
        rangeOneText.snp.makeConstraints { (make) in
            make.centerY.equalTo(lunchRangeView1).offset(2)
            make.right.equalTo(lunchRangeView1).offset(-18)
        }
        let lunchViewStroke = UIView()
        mainLunchView.addSubview(lunchViewStroke)
        lunchViewStroke.backgroundColor = K.Colors.thickGreen
        lunchViewStroke.snp.makeConstraints { (make) in
            make.centerY.equalTo(lunchRangeView1)
            make.height.equalTo(mainLunchView).multipliedBy(0.35)
            make.width.equalTo(2)
            make.right.equalTo(rangeOneText.snp.left).offset(-20)
        }

        let carFuelView1 = UIView()
        carFuelView.addSubview(carFuelView1)
        carFuelView1.snp.makeConstraints { (make) in
            make.top.equalTo(carFuelView)
            make.left.right.equalTo(carFuelView)
            make.height.equalTo(carFuelView).multipliedBy(0.3)
        }
        let houseImageView = UIImageView()
        carFuelView1.addSubview(houseImageView)
        houseImageView.image = UIImage(named: "house")
        houseImageView.clipsToBounds = true
        houseImageView.snp.makeConstraints { (make) in
            make.left.equalTo(carFuelView1).offset(18)
            make.centerY.equalTo(carFuelView1)
            make.height.width.equalTo(carFuelView1.snp.height).multipliedBy(0.4)
        }
        let carFuelText = UILabel()
        carFuelView1.addSubview(carFuelText)
        paragraphStyle.lineHeightMultiple = 1.0
        carFuelText.attributedText = NSMutableAttributedString(string: "Car Fuel", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        carFuelText.textColor = .black
        carFuelText.font = UIFont(name: K.Fonts.light, size: 14)
        carFuelText.snp.makeConstraints { (make) in
            make.centerY.equalTo(houseImageView).offset(2)
            make.left.equalTo(houseImageView.snp.right).offset(11)
        }

        let carFuelAmountText = UILabel()
        carFuelView1.addSubview(carFuelAmountText)
        carFuelAmountText.attributedText = NSMutableAttributedString(string: "$20/day", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        carFuelAmountText.textColor = .black
        carFuelAmountText.font = UIFont(name: K.Fonts.light, size: 14)
        carFuelAmountText.snp.makeConstraints { (make) in
            make.centerY.equalTo(houseImageView).offset(2)
            make.right.equalTo(carFuelView1).offset(-15)
        }

        let carFuelView2 = UIView()
        carFuelView.addSubview(carFuelView2)
        carFuelView2.addViewBorderColor()
        carFuelView2.snp.makeConstraints { (make) in
            make.bottom.equalTo(carFuelView)
            make.left.right.equalTo(carFuelView)
            make.height.equalTo(carFuelView).multipliedBy(0.3)
        }
        let fuelCheckImageView = UIImageView()
        carFuelView2.addSubview(fuelCheckImageView)
        fuelCheckImageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(K.Colors.thickGreen ?? UIColor(), renderingMode: .alwaysOriginal)
        fuelCheckImageView.clipsToBounds = true
        fuelCheckImageView.snp.makeConstraints { (make) in
            make.left.equalTo(carFuelView2).offset(18)
            make.centerY.equalTo(carFuelView2)
            make.height.width.equalTo(carFuelView2.snp.height).multipliedBy(0.4)
        }
        let carFuelText2 = UILabel()
        carFuelView2.addSubview(carFuelText2)
        paragraphStyle.lineHeightMultiple = 1.0
        carFuelText2.attributedText = NSMutableAttributedString(string: "Your food spending is still on track", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        carFuelText2.textColor = .systemGray
        carFuelText2.font = UIFont(name: K.Fonts.light, size: 14)
        carFuelText2.snp.makeConstraints { (make) in
            make.centerY.equalTo(fuelCheckImageView).offset(2)
            make.left.equalTo(fuelCheckImageView.snp.right).offset(10)
        }
        let carFuelRangeView1 = UIView()
        carFuelView.addSubview(carFuelRangeView1)
        carFuelRangeView1.backgroundColor = K.Colors.rangeColor
        carFuelRangeView1.clipsToBounds = true
        carFuelRangeView1.layer.cornerRadius = 22
        carFuelRangeView1.snp.makeConstraints { (make) in
            make.centerY.equalTo(carFuelView).offset(-7)
            make.right.equalTo(carFuelView).offset(-15)
            make.left.equalTo(carFuelView).offset(15)
            make.height.equalTo(carFuelView).multipliedBy(0.25)
        }
        let carFuelRangeView2 = UIView()
        carFuelRangeView1.addSubview(carFuelRangeView2)
        carFuelRangeView2.backgroundColor = K.Colors.thickGreen
        carFuelRangeView2.layer.cornerRadius = 22
        carFuelRangeView2.snp.makeConstraints { (make) in
            make.centerY.equalTo(carFuelRangeView1)
            make.left.equalTo(carFuelRangeView1)
            make.width.equalTo(carFuelRangeView1).multipliedBy(0.65)
            make.height.equalTo(carFuelRangeView1)
        }

        let carRangeTwoText = UILabel()
        carFuelRangeView2.addSubview(carRangeTwoText)
        carRangeTwoText.attributedText = NSMutableAttributedString(string: "$600", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        carRangeTwoText.textColor = .white
        carRangeTwoText.font = UIFont(name: K.Fonts.light, size: 14)
        carRangeTwoText.snp.makeConstraints { (make) in
            make.centerY.equalTo(carFuelRangeView2).offset(2)
            make.left.equalTo(carFuelRangeView2).offset(18)
        }

        let carRangeOneText = UILabel()
        carFuelRangeView1.addSubview(carRangeOneText)
        carRangeOneText.attributedText = NSMutableAttributedString(string: "$900", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        carRangeOneText.textColor = .systemGray
        carRangeOneText.font = UIFont(name: K.Fonts.light, size: 14)
        carRangeOneText.snp.makeConstraints { (make) in
            make.centerY.equalTo(carFuelRangeView1).offset(2)
            make.right.equalTo(carFuelRangeView1).offset(-18)
        }
        let carViewStroke = UIView()
        carFuelView.addSubview(carViewStroke)
        carViewStroke.backgroundColor = K.Colors.thickGreen
        carViewStroke.snp.makeConstraints { (make) in
            make.centerY.equalTo(carFuelRangeView1)
            make.height.equalTo(carFuelView).multipliedBy(0.35)
            make.width.equalTo(2)
            make.right.equalTo(carRangeOneText.snp.left).offset(-20)
        }
        
        
        
    }
    
    //Card View
    func setupCardsView() {
        scrollView.addSubview(cardsView)
        cardsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cardsView.backgroundColor = .white
        cardsView.layer.cornerRadius = 20
        cardsView.clipsToBounds = true
        cardsView.snp.makeConstraints { (make) in
            make.top.equalTo(activityView.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(scrollView).multipliedBy(0.99)
            make.bottom.equalTo(scrollView).offset(-10)
        }
        let cardViewIndicator = UIView()
        cardViewIndicator.backgroundColor = K.Colors.rangeColor
        cardsView.addSubview(cardViewIndicator)
        cardViewIndicator.clipsToBounds = true
        cardViewIndicator.layer.cornerRadius = 5
        cardViewIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardsView)
            make.width.equalTo(view).multipliedBy(0.2)
            make.height.equalTo(6)
            make.top.equalTo(cardsView).offset(20)
        }
        
        cardsView.addSubview(cardTitle)
        paragraphStyle.lineHeightMultiple = 1.1
        cardTitle.attributedText = NSMutableAttributedString(string: "Cards", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        cardTitle.textColor = .black
        cardTitle.font = UIFont(name: K.Fonts.medium, size: 27)
        cardTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cardViewIndicator).offset(20)
            make.left.equalTo(cardsView).offset(15)
        }
        
        let elipses = UILabel()
        cardsView.addSubview(elipses)
        elipses.attributedText = NSMutableAttributedString(string: "• •", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        elipses.textColor = .black
        elipses.font = UIFont(name: K.Fonts.medium, size: 20)
        elipses.snp.makeConstraints { (make) in
            make.top.equalTo(cardViewIndicator).offset(20)
            make.right.equalTo(cardsView).offset(-15)
        }
    }
    
    func setupCardScrollView() {
        cardsView.addSubview(cardScrollView)
        cardScrollView.frame = cardScrollView.bounds
        cardScrollView.showsHorizontalScrollIndicator = false
        cardScrollView.autoresizingMask = .flexibleWidth
        cardScrollView.contentSize = CGSize(width: cardsView.frame.width + 500, height: 205)
        cardScrollView.bounces = true
        cardScrollView.contentOffset = CGPoint(x:0, y:150)
        cardScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(cardTitle.snp.bottom).offset(30)
            make.width.equalTo(cardsView)
            make.height.equalTo(cardsView).multipliedBy(0.45)
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
            make.height.equalTo(cardsView).multipliedBy(0.4)
        }

        let card1Text = UILabel()
        card1.addSubview(card1Text)
        card1Text.attributedText = NSMutableAttributedString(string: "Fundall Lifestyle Card", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        card1Text.textColor = .black
        card1Text.font = UIFont(name: K.Fonts.medium, size: 10)
        card1Text.snp.makeConstraints { (make) in
            make.top.equalTo(card1).offset(15)
            make.left.equalTo(card1).offset(11)
        }
        
        let card2 = UIControl()
        cardScrollView.addSubview(card2)
        card2.backgroundColor = .systemGray
        card2.clipsToBounds = true
        card2.layer.cornerRadius = 12
        card2.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardScrollView)
            make.left.equalTo(card1.snp.right).offset(15)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(cardsView).multipliedBy(0.4)
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
        card3.clipsToBounds = true
        card3.layer.cornerRadius = 12
        card3.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardScrollView)
            make.left.equalTo(card2.snp.right).offset(15)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(cardsView).multipliedBy(0.4)
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
    
    func setupCardTableView() {
        let tableTitle = UILabel()
        cardsView.addSubview(tableTitle)
        paragraphStyle.lineHeightMultiple = 1.1
        tableTitle.attributedText = NSMutableAttributedString(string: "Today", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tableTitle.textColor = .black
        tableTitle.font = UIFont(name: K.Fonts.medium, size: 27)
        tableTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cardScrollView.snp.bottom).offset(20)
            make.left.equalTo(cardsView).offset(15)
        }
        
        let viewAllText = UILabel()
        cardsView.addSubview(viewAllText)
        viewAllText.attributedText = NSMutableAttributedString(string: "View all", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        viewAllText.textColor = .systemGray
        viewAllText.font = UIFont(name: K.Fonts.medium, size: 15)
        viewAllText.snp.makeConstraints { (make) in
            make.centerY.equalTo(tableTitle)
            make.right.equalTo(cardsView).offset(-15)
        }
        //Setup table view
        cardsView.addSubview(cardTableView)
        //Set Delegate
        cardTableView.delegate = self
        cardTableView.dataSource = self
        //Set the height
        cardTableView.rowHeight = 80
        cardTableView.backgroundColor = .white
        cardTableView.separatorColor = .clear
        cardTableView.register(CardViewCell.self, forCellReuseIdentifier: K.reuseIdentifier)
        //Set Constraints
        cardTableView.snp.makeConstraints { (make) in
            make.top.equalTo(tableTitle.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.bottom.equalTo(cardsView)
        }
    }
    
    //MARK: - Helpers
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func handleExitButton(_ sender: UIButton) {
        let destinationVc = LoginViewController()
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
    
    @objc func requestCardButton(_ sender: UIButton) {
        let destinationVc = UINavigationController(rootViewController: PickCardViewController())
        destinationVc.modalPresentationStyle = .fullScreen
        present(destinationVc, animated: true)
    }
    
    @objc func importPicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardTableView.dequeueReusableCell(withIdentifier: K.reuseIdentifier, for: indexPath) as? CardViewCell
        let cards = cardCells[indexPath.row]
        cell?.amountLabel.text = cards.amount
        cell?.amountLabel.textColor = cards.amountLabelColor
        cell?.cellImageView.image = cards.featuredImage
        cell?.time.text = cards.time
        cell?.titleLabel.text = cards.title
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell?.selectedBackgroundView = bgColorView
        return cell ?? UITableViewCell()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        profileImageView.image = currentImage
        uploadProfileImage()
    }
}

extension HomeViewController {
    func uploadProfileImage() {
        ApiClientWithHeaders.shared.requestImageUpload(image: currentImage) { (response, error) in
            if let successResp = response {
                print(successResp.success?.message ?? String())
            }
            if let failure = error {
                print("Error\(failure)")
            }
        }
    }
}
