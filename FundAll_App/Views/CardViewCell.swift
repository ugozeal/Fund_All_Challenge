//
//  CardViewCell.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import UIKit
import SnapKit

class CardViewCell: UITableViewCell {
    //MARK: - Private Properties
    let paragraphStyle = NSMutableParagraphStyle()
    var mainCardView = UIView()
    var cellImageView = UIImageView()
    var amountLabel = UILabel()
    var titleLabel = UILabel()
    var time = UILabel()
    
    
    //MARK: Overrides
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Actions
    func updateUI() {
        setupMainCard()
        setupImage()
        setupAmountLabel()
        creatTitleView()
    }
    
    //MARK:- Setup Views
    func setupMainCard() {
        addSubview(mainCardView)
        mainCardView.backgroundColor = .white
        mainCardView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-16)
            make.bottom.equalTo(-10)
            make.left.equalTo(16)
        }
    }
    
    func setupImage() {
        mainCardView.addSubview(cellImageView)
        cellImageView.layer.cornerRadius = 30
        cellImageView.backgroundColor = K.Colors.cardImageBg
        cellImageView.clipsToBounds = true
        cellImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(mainCardView)
            make.left.equalTo(mainCardView).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    func setupAmountLabel() {
        mainCardView.addSubview(amountLabel)
        paragraphStyle.lineHeightMultiple = 1.0
        amountLabel.attributedText = NSMutableAttributedString(string: "₦ 130", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        amountLabel.textColor = .systemGray
        amountLabel.font = UIFont(name: K.Fonts.bold, size: 17)
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(mainCardView).offset(-8)
            make.right.equalTo(mainCardView).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(mainCardView).multipliedBy(0.3)
        }
    }

    func creatTitleView() {
        paragraphStyle.lineHeightMultiple = 1.0
        //Set titleLabel
        mainCardView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: K.Fonts.medium, size: 18)
        titleLabel.attributedText = NSMutableAttributedString(string: "Tobilola", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellImageView).offset(10)
            make.left.equalTo(cellImageView.snp.right).offset(10)
        }
        
        //Set timeLabel
        mainCardView.addSubview(time)
        time.textColor = .systemGray
        time.font = UIFont(name: K.Fonts.medium, size: 15)
        time.attributedText = NSMutableAttributedString(string: "Just now", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        time.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(cellImageView.snp.right).offset(10)
        }
        
    }
    
    
}
