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
    //MARK: -Auth
    enum Auth {
        static var email: String { "email".localized}
        static var enterEmail: String { "enterEmail".localized }
        static var forgotPassword: String { "forgotPassword".localized }
        static var password: String { "password".localized }
        static var enterPassword: String { "enterPassword".localized }
        static var welcomeBack: String { "welcomeBack".localized }
        static var login: String { "login".localized }
        static var newAccount: String { "newAccount".localized }
        static var cancel: String { "cancel".localized }
        static var niceToMeetYou: String { "niceToMeetYou".localized }
        static var repeatPassword: String { "repeatPassword".localized }
        static var register: String { "register".localized }
        static var iHaveAnAccount: String { "iHaveAnAccount".localized }
        static var reset: String { "reset".localized }
        static var enterYourEmailAdressAndWeWillShareALinkToCreateANewPassword: String {
            "enterYourEmailAdressAndWeWillShareALinkToCreateANewPassword".localized
        }
        static var resetPassword: String { "resetPassword".localized }
        static var nonValidPassword: String { "nonValidPassword".localized }
        static var wrongEmail: String { "wrongEmail".localized }
        static var passwordDoesNotMatch: String { "passwordDoesNotMatch".localized }
    }
    
    //MARK: -Onboarding
    enum Onboarding {
        static var next: String { "next".localized }
        static var done: String { "done".localized }
        static var welcome: String { "welcome".localized }
        static var noteme_is_an_application_which_notify_you_about_everything: String {
            "noteme_is_an_application_which_notify_you_about_everything".localized
        }
        static var different_types: String { "different_types".localized }
        static var calendar: String { "calendar".localized }
        static var location: String { "location".localized }
        static var timer: String { "timer".localized }
        static var you_can_use_three_types_of_notifications: String {
            "you_can_use_three_types_of_notifications".localized
        }
    }
    
    //MARK: -AlertBuilder
    enum AlertBuilder {
        static var error: String {"error".localized}
        static var we_have_sent_a_link_to_reset_your_password_to: String {
            "we_have_sent_a_link_to_reset_your_password_to".localized
        }
        static var ok: String { "ok".localized }
        static var success: String { "success".localized }
        static var invalid_email_address: String { "invalid_email_address".localized }
        static var invalid_email_or_password: String { "invalid_email_or_password".localized }
        static var logout: String { "logout".localized }
        static var are_you_want_to_logout: String { "are_you_want_to_logout".localized }
        static var cancel: String { "cancel".localized }
    }
    
    //MARK: -Home
    enum Home {
        static var home: String { "home".localized }
    }
    
    //MARK: -Profile
    enum Profile {
        static var profile: String { "profile".localized }
        static var account: String { "account".localized }
        static var settings: String { "settings".localized }
        static var your_email: String { "your_email".localized }
        static var notificactions: String { "notificactions".localized }
        static var export: String { "export".localized }
        static var logout: String { "logout".localized }
        static var unregistered_user: String { "unregistered_user".localized }
        static var map: String { "map".localized }
    }
    
    //MARK: -MainTabBar
    enum MainTabBar {
        static var calendar: String { "calendar".localized }
        static var location: String { "location".localized }
        static var timer: String { "timer".localized }
        static var edit: String { "edit".localized }
        static var delete: String { "delete".localized }
    }
    
    //MARK: -Notification
    enum Notification {
        static var create: String { "create".localized }
        static var create_date_notification: String { "create_date_notification".localized }
        static var create_timer_notification: String { "create_timer_notification".localized }
        static var create_location_notification: String { "create_location_notification".localized }
        static var title: String { "title".localized }
        static var enter_title: String { "enter_title".localized }
        static var date: String { "date".localized }
        static var enter_date: String { "enter_date".localized }
        static var comment: String { "comment".localized }
        static var enter_comment: String { "enter_comment".localized }
        static var timer: String { "timer".localized }
        static var enter_timer: String { "enter_timer".localized }
    }
    
    //MARK: -Map
    enum Map {
        static var search: String { "search".localized }
        static var select: String { "select".localized }
        static var confirm: String { "confirm".localized }
        static var location: String { "location".localized }
    }
}

