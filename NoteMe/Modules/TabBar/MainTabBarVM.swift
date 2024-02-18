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
    
}

extension MainTabBarVM: PopoverVCDelegate {
    func didSelectCalendar() {
        coordinator?.openNewDateNotification()
    }
    func didSelectLocation() {
        coordinator?.openNewLocationNotification()
    }
    
    func didSelectTimer() {
        coordinator?.openNewTimerNotification()
    }

}
