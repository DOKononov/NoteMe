//
//  MainTabBarAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class MainTabBarAssembler {
    private init() {}
    
    static func make(coordinator: MainTabBarCoordinatorProtocol?) -> UITabBarController {
        let viewModel = MainTabBarVM(coordinator: coordinator)
        let tabBar = MainTabBarVC(viewModel: viewModel)
        return tabBar
    }
}
