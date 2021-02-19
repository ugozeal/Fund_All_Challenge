//
//  Request.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import Foundation
import ObjectMapper

//{
//"firstname": “Test",
//"lastname": “Test",
//    "email": “test@gmail.com",
//    "password": "123456",
//    "password_confirmation": “123456",
//}

class RegistrationReq: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var passwordConfirmation: String?
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        password <- map["password"]
        passwordConfirmation <- map["passwordConfirmation"]
    }
    
    private enum CodingKeys: String, CodingKey {
          case passwordConfirmation = "password_confirmation", email, password, firstName = "firstname", lastName = "lastname"
      }
}

class AuthenticateUserReq: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    var email: String?
    var password: String?
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
    
}

class UpDateAvatar: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    var avatar: Data?
    func mapping(map: Map) {
        avatar <- map["avatar"]
    }
}
