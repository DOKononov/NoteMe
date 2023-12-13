//
//  Localization+AlertBuilder.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.12.23.
//

import Foundation

extension String.AlertBuilder {
    static var error: String {
        "error".localized
    }
    static var we_have_sent_a_link_to_reset_your_password_to: String {
        "we_have_sent_a_link_to_reset_your_password_to".localized
    }
    static var ok: String {
        "ok".localized
    }
    static var success: String {
        "success".localized
    }
    static var invalid_email_address: String {
        "invalid_email_address".localized
    }
    
    static var invalid_email_or_password: String {
        "invalid_email_or_password".localized
    }
}
