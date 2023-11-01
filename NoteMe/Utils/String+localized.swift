//
//  String+localized.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import Foundation

extension String {
   var localized: String {
       return NSLocalizedString(self, comment: "")
   }
}

extension String {
    enum LoginVC {}
}


extension String.LoginVC {
    static var email: String {
        "email".localized
    }
    
    static var enterEmail: String {
        "enterEmail".localized
    }
    
    static var forgotPassword: String {
        "forgotPassword".localized
    }
    
    static var password: String {
        "password".localized
    }
    
    static var enterPassword: String {
        "enterPassword".localized
    }
    
    static var welcomeBack: String {
        "welcomeBack".localized
    }
    
    static var login: String {
        "login".localized
    }
    
    static var newAccount: String {
        "newAccount".localized
    }
    
    static var cancel: String {
        "cancel".localized
    }
}
