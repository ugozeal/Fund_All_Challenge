//
//  GenericResponse.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import Foundation
import ObjectMapper

//
//{
//    "success": {
//        "status": "SUCCESS",
//        "url": "https://res.cloudinary.com/fundaller/image/upload/v1613761029/4d0e74c8-a1fc-4610-8385-0905e68d0b50.jpg",
//        "message": "Avatar uploaded successfully"
//    }
//}
class AvatarResponse: Mappable, Decodable {
    required convenience init?(map: Map) {
        self.init()
    }
    var success: AvatarSuccess?
    func mapping(map: Map) {
        success <- map["success"]
    }
}

class AvatarSuccess: Mappable, Decodable {
    required convenience init?(map: Map) {
        self.init()
    }
    var status: String?
    var message: String?
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
}

class RegistrationResponse: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    var success: RegistrationSuccess?
    func mapping(map: Map) {
        success <- map["success"]
    }
}

class RegistrationSuccess: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var message: String?
    var status: String?
    func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}

class AuthenticationResponse: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var success: AuthenticationSuccess?
    
    func mapping(map: Map) {
        success <- map["success"]
    }
    
}

//class Success: Codable {

//
//    init(user: User?, status: String?) {
//        self.user = user
//        self.status = status
//    }
//}
class AuthenticationSuccess: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var user: User?
    var status: String?
    func mapping(map: Map) {
        status <- map["status"]
        user <- map["user"]
    }
    
}

class User: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var id: Int?
    var firstname: String?
    var lastname: String?
    var email: String?
    var avatar: String?
    var monthlyTarget: Double?
    var createdAt: String?
    var updatedAt: String?
    var accessToken: String?
    var tokenType: String?
    var expiresAt: String?
    func mapping(map: Map) {
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        email <- map["email"]
        id <- map["id"]
        avatar <- map["avatar"]
        monthlyTarget <- map["monthlyTarget"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        accessToken <- map["accessToken"]
        tokenType <- map["tokenType"]
        expiresAt <- map["expiresAt"]
    }
    
    enum CodingKeys: String, CodingKey {
          case id, firstname, lastname, email, avatar
          case monthlyTarget = "monthly_target"
          case createdAt = "created_at"
          case updatedAt = "updated_at"
          case accessToken = "access_token"
          case tokenType = "token_type"
          case expiresAt = "expires_at"
      }
}

class GetClientDataResponse: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var success: ClientSuccessResponse?
    func mapping(map: Map) {
        success <- map["success"]
    }
}

class ClientSuccessResponse: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var status: String?
    var data: ClientData?
    
    func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
    }
}

class ClientData: Mappable, Codable {
    required convenience init?(map: Map) {
        self.init()
    }
    var id: Int?
    var firstname: String?
    var lastname: String?
    var email: String?
    var avatar: String?
    var totalBalance: String?
    var income: String?
    var spent: String?

    func mapping(map: Map) {
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        email <- map["email"]
        id <- map["id"]
        avatar <- map["avatar"]
        totalBalance <- map["totalBalance"]
        income <- map["income"]
        spent <- map["spent"]
    }

    enum CodingKeys: String, CodingKey {
        case id, firstname, lastname, avatar, email
        case totalBalance = "total_balance"
        case income, spent
    }

}
