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
    enum Auth {}
    enum Onboarding {}
    enum AlertBuilder {}
    enum Home {}
    enum Profile {}
    enum MainTabBar {}
    enum DateNotification {}
    enum TimerNotification {}
    enum LocationNotification {}
}

