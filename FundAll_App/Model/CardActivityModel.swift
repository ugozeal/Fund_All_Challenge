//
//  CardActivityModel.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import UIKit

class CardActivityModel {
    var featuredImage = UIImage()
    var title = ""
    var time = ""
    var amount = ""
    var amountLabelColor = UIColor()
    var isDone: Bool = false
    
    init(featuredImage: UIImage ,title: String, time: String, amount: String, amountLabelColor: UIColor) {
        self.featuredImage = featuredImage
        self.title = title
        self.time = time
        self.amount = amount
        self.amountLabelColor = amountLabelColor
    }
    
    static func createCardActivityCells() -> [CardActivityModel] {
        return [
            CardActivityModel(featuredImage: UIImage(named: "plane") ?? UIImage(), title: "Tabilola", time: "Just now", amount: "₦ 130", amountLabelColor: K.Colors.defaultGreen ?? UIColor()),
            CardActivityModel(featuredImage: UIImage(named: "diamond") ?? UIImage(), title: "Grocery", time: "12:00 PM", amount: "₦ 100", amountLabelColor: .systemPink),
            CardActivityModel(featuredImage: UIImage(named: "gift-box") ?? UIImage(), title: "Shopping", time: "8:00 AM", amount: "₦ 30", amountLabelColor: .systemPink),
            CardActivityModel(featuredImage: UIImage(named: "cup") ?? UIImage(), title: "Alvare", time: "00:00 AM", amount: "₦ 30", amountLabelColor: K.Colors.defaultGreen ?? UIColor())
        ]
    }
    
    static func pickCardCells() -> [CardActivityModel] {
        return [
            CardActivityModel(featuredImage: UIImage(named: "plane") ?? UIImage(), title: "Lifestyle Pro", time: "₦ 9500", amount: "₦ 130", amountLabelColor: K.Colors.defaultGreen ?? UIColor()),
            CardActivityModel(featuredImage: UIImage(named: "diamond") ?? UIImage(), title: "Lifestyle Premium", time: "₦ 1,000", amount: "₦ 100", amountLabelColor: .systemPink),
            CardActivityModel(featuredImage: UIImage(named: "gift-box") ?? UIImage(), title: "Lifestyle Business", time: "₦ 1,200", amount: "₦ 30", amountLabelColor: .systemPink)
        ]
    }

}
