//
//  TouchIDAuth.swift
//  Interviewing
//
//  Created by Алексей on 22.12.2017.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import LocalAuthentication

class TouchIDAuth{
    let context = LAContext()
    
    func canTouchIDAuth() -> Bool{
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(completion: @escaping (String?) -> Void){
        guard canTouchIDAuth() else {
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Вход в систему с помощью Touch ID") { (success, valueError) in
            if success {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                var message: String = ""
                switch valueError! {
                case  LAError.authenticationFailed:
                        message = "Не удалось проверить вашу личность."
                case  LAError.userCancel:
                        message = "Вы нажали отменить"
                case  LAError.userFallback:
                        message = "Вы нажали пароль"
                    default:
                        message = "Touch ID не может быть настроен"
                }
                completion(message)
            }
        }
    }
}
