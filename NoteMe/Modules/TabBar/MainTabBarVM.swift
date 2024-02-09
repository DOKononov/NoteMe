//
//  MainTabBarVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 8.02.24.
//

import Foundation

protocol MainTabBarCoordinatorProtocol: AnyObject {
    func openNewDateNotification()
    func openNewTimerNotification()
    func openNewLocationNotification()
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
    
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    init(coordinator: MainTabBarCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func makeDateNotification() {
        coordinator?.openNewDateNotification()
    }
    
    func makeLocationNotification() {
        coordinator?.openNewLocationNotification()
    }
    
    func makeTimerNotification() {
        coordinator?.openNewTimerNotification()
    }
}
