//
//  NetworkClass.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import Foundation
import UIKit

final class NetworkClass {
    static let shared = NetworkClass()
}

extension NetworkClass {
    // Register new User
    func registerNewUser(requestModel: RegistrationReq, success: @escaping (RegistrationResponse) -> (), failure: @escaping (String) -> ()) {
        ApiClientWithHeaders.shared.execute(requestType: .post, headers: ["Accept" : "application/json"], url: K.URL.register, params: ["firstname": requestModel.firstName ?? String(), "lastname": requestModel.lastName ?? String(), "email": requestModel.email ?? String(), "password": requestModel.password ?? String(), "password_confirmation": requestModel.passwordConfirmation ?? String()]) { (successMessage) in
            success(successMessage)
        } failure: { (error) in
            failure(error)
        }
    }
    
    //Login
    func loginUser(requestModel: AuthenticateUserReq, success: @escaping (AuthenticationResponse) -> (), failure: @escaping (String) -> ()) {
        ApiClientWithHeaders.shared.execute(requestType: .post, headers: ["Accept" : "application/json"], url: K.URL.login, params: ["email": requestModel.email ?? String(), "password": requestModel.password ?? String()]) { (successMessage) in
            success(successMessage)
        } failure: { (error) in
            failure(error)
        }
    }
    
    //Load Data
    func loadUserData(success: @escaping (GetClientDataResponse) -> (),  failure: @escaping (String) -> ()){
        let token = UserDefaults.standard.string(forKey: "loginToken")
        ApiClientWithHeaders.shared.loadData(headers: ["Authorization": "Bearer \(token ?? String())"], url: K.URL.loadData) { (successMessage) in
            success(successMessage)
        } failure: { (error) in
            failure(error)
        }
    }
    
    //Upload Avatar
    func uploadAvatar(requestModel: UpDateAvatar, success: @escaping (AvatarResponse) -> (), failure: @escaping (String) -> ()) {
        let token = UserDefaults.standard.string(forKey: "loginToken")
        ApiClientWithHeaders.shared.execute(requestType: .post, headers: ["Authorization": "Bearer \(token ?? String())", "Content-Type": "multipart/form-data"], url: K.URL.upDateAvatar, params: ["avatar": requestModel.avatar ?? Data()]) { (successMessage) in
            success(successMessage)
        } failure: { (error) in
            failure(error)
        }
    }
    
}
