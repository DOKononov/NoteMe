//
//  ProfileSections.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.01.24.
//

import UIKit

enum ProfileSections: Equatable {
    case account(String)
    case notifications(ProfileSettingsRows)
    case settings([ProfileSettingsRows])
    
    var numberOfRows: Int {
        switch self {
        case .settings(let rows): rows.count
        default: 1
        }
    }
    
    var headerText: String {
        switch self {
        case .account: .Profile.account
        case .notifications: .Profile.notificactions
        case .settings: .Profile.settings
        }
    }
}

enum ProfileSettingsRows: CaseIterable {
    case notifications
    case export
    case logout
    case map
    
    var icon: UIImage {
        switch self {
        case .notifications: .Profile.notificactions
        case .export: .Profile.export
        case .logout: .Profile.logout
        case .map: .MainTabBar.location

        }
    }
    
    var title: String {
        switch self {
        case .notifications: .Profile.notificactions
        case .export: .Profile.export
        case .logout: .Profile.logout
        case .map: .Profile.map

        }
    }
    
    var subTitle: String? {
        switch self {
        case .export: "Last export: 20 Sep 2023"
        default: nil
        }
    }
}
