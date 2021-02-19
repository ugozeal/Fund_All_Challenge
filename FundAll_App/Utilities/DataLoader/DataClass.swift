//
//  DataClass.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/18/21.
//

import Foundation
import Alamofire

final class ApiClientWithHeaders {
    static let shared = ApiClientWithHeaders()
}


extension ApiClientWithHeaders {
    enum HttpMethodType: String {
        case get, post, patch, delete, put
    }

    func execute <DataModel: Decodable> (requestType: HttpMethodType = .get, headers: HTTPHeaders , url: String, params: [String: Any] = [:], success: @escaping (DataModel) -> (), failure: @escaping (String) -> ()) {
        let convertedHttpMethod = httpMethodConversion(httpMethod: requestType)
        AF.request(url, method: convertedHttpMethod, parameters: params, encoding:
                    JSONEncoding.default, headers: headers).responseDecodable(of: DataModel.self) { response in
                if let error = response.error {
                    failure(error.localizedDescription)
                    return
                }
                if let result = response.value {
                    success(result)
                    return
                }
        }
    }
    
    func loadData <DataModel: Decodable> (requestType: HttpMethodType = .get, headers: HTTPHeaders, url: String, success: @escaping (DataModel) -> (), failure: @escaping (String) -> ()) {
        let convertedHttpMethod = httpMethodConversion(httpMethod: requestType)
        AF.request(url, method: convertedHttpMethod, encoding:
                    JSONEncoding.default, headers: headers).responseDecodable(of: DataModel.self){ response in
                if let error = response.error {
                    failure(error.localizedDescription)
                    return
                }
                if let result = response.value {
                    success(result)
                    return
                }
        }
    }
    
    func requestImageUpload(image: UIImage?, completion: @escaping(AvatarResponse?, Error?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "loginToken")
        let url = K.URL.upDateAvatar
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token!)",
                "Accept": "multipart/form-data"
            ]
            AF.upload(
                multipartFormData: { (MultipartFormData) in
                    MultipartFormData.append(image!.jpegData(compressionQuality: 0.1)!, withName: "avatar", fileName: "file.jpeg", mimeType: "image/jpeg")
                }, to: url, method: .post, headers: headers
            ).responseDecodable(of: AvatarResponse.self) {
                response in
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                if let result = response.value {
                    completion(result, nil)
                    return
                }
            }
        }
    
    // This function converts httpMethodType enum (business logic) to Alamofire httpmethod
    private func httpMethodConversion(httpMethod: HttpMethodType) -> HTTPMethod {
        let requestTypeRawValue = httpMethod.rawValue
        let convertedHttpMethod = HTTPMethod(rawValue: requestTypeRawValue)
        return convertedHttpMethod
    }
}
