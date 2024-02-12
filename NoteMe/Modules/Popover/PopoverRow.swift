//
//  PopoverRow.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.02.24.
//

import UIKit

enum PopoverRow {
    case calendar
    case location
    case timer
    case edit
    case delete
    
    var title: String {
        switch self {
        case .calendar: String.MainTabBar.calendar
        case .location: String.MainTabBar.location
        case .timer: String.MainTabBar.timer
        case .edit: String.MainTabBar.edit
        case .delete: String.MainTabBar.delete
        }
    }
    
    var image: UIImage {
        switch self {
        case .calendar: UIImage.MainTabBar.calendar
        case .location: UIImage.MainTabBar.location
        case .timer: UIImage.MainTabBar.timer
        case .edit: UIImage.MainTabBar.edit
        case .delete: UIImage.MainTabBar.delete
        }
    }
}
