//
//  FingerPrintUtilities.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/17/21.
//

import UIKit
import LocalAuthentication

final class FingerprintUtils {
    static let shared = FingerprintUtils()
}

extension FingerprintUtils {
    
    static func authenticationWithTouchID(vc: UIViewController, onSuccess: @escaping () -> (), onFailed: @escaping (_ reason:String) -> ()) {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        onSuccess()
                    }
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    onFailed(error.localizedDescription)
                    print(error)
                }
            }
        } else {
            guard let error = authorizationError else {
                return
            }
            onFailed(error.localizedDescription)
            print(error)
        }
    }
}

