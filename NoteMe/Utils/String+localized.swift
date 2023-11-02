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
    
    static var niceToMeetYou: String {
        "niceToMeetYou".localized
    }
    
    static var repeatPassword: String {
        "repeatPassword".localized
    }
    
    static var register: String {
        "register".localized
    }
    
    static var iHaveAnAccount: String {
        "iHaveAnAccount".localized
    }
    
    static var reset: String {
        "reset".localized
    }
    
    static var enterYourEmailAdressAndWeWillShareALinkToCreateANewPassword: String {
        "enterYourEmailAdressAndWeWillShareALinkToCreateANewPassword".localized
    }
    
    static var resetPassword: String {
        "resetPassword".localized
    }
    
}
