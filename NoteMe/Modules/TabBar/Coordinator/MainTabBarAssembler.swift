//
//  MainTabBarAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class MainTabBarAssembler {
    private init() {}
    
    static func make() -> UITabBarController {
        let viewModel = MainTabBarVM()
        let tabBar = MainTabBarVC(viewModel: viewModel)
        return tabBar
    }
}
