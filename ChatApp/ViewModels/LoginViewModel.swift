//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/14/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift

class LoginViewModel {
    
    var isValid = Variable<Bool>(false)
    
    func loginAnonymous() {
        Auth.auth().signInAnonymously(completion: { (authResult, error) in
            if let uid = authResult?.user.uid {
                print("UID is \(uid)")
                self.isValid.value = true
            } else {
                print("Login error \(String(describing: error))")
            }
        })
    }
}
