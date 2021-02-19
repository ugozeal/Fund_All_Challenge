//
//  StringConstants.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit

enum K {
    static let reuseIdentifier = "cell"
    static let privacyPolicy = "By clicking on Sign up, you agree to our terms & conditions and privacy policy."
    static let privacyRange1 = "terms & conditions"
    static let privacyRange2 = "privacy policy."
    enum Colors {
        static let defaultGreen = UIColor(named: "defaultGreen")
        static let homeBgColor = UIColor(named: "home-background")
        static let thickGreen = UIColor(named: "splash-Screen-Color")
        static let rangeColor = UIColor(named: "rangeColor")
        static let cardImageBg = UIColor(named: "cardImageBg")
    }
    
    enum Fonts {
        static let regular = "FoundersGrotesk-Regular"
        static let bold = "FoundersGrotesk-Bold"
        static let medium = "FoundersGrotesk-Medium"
        static let regularItalics = "FoundersGrotesk-RegularItalic"
        static let light = "FoundersGrotesk-Light"
    }
    
    enum Images {
        static let person = "person"
        static let phone = "phone"
        static let lock = "lock"
        static let message = "message"
        static let envelope = "envelope"
    }
    enum URL {
        static let baseUrl = "https://campaign.fundall.io/"
        static let register = baseUrl + "api/v1/register"
        static let login = baseUrl + "api/v1/login"
        static let loadData = baseUrl + "api/v1/base/profile"
        static let upDateAvatar = baseUrl + "api/v1/base/avatar"
    }
}
