//
//  UIImage+Consts.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit

extension UIImage {
    
    enum General {
        static let logo: UIImage = .init(named: "logo")!
        static let tabBarAddButton: UIImage = .init(named: "tabBarAddButton")!
    }
    
    enum Onboarding {
        static let popup: UIImage = .init(named: "popup")!
    }
    
    enum Home {
        static let home: UIImage = .init(named: "home")!
    }
    
    enum Profile {
        static let profile: UIImage = .init(named: "profile")!
        static let export: UIImage = .init(named: "export")!
        static let logout: UIImage = .init(named: "logout")!
        static let notificactions: UIImage = .init(named: "notificactions")!
    }
    
    enum MainTabBar {
        static let calendar: UIImage = .init(named: "calendar")!
        static let delete: UIImage = .init(named: "delete")!
        static let edit: UIImage = .init(named: "edit")!
        static let location: UIImage = .init(named: "location")!
        static let timer: UIImage = .init(named: "timer")!
        static let settings: UIImage = .init(named: "settings")!
    }
}
