//
//  MainTabBarVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 8.02.24.
//

import UIKit

protocol MainTabBarCoordinatorProtocol: AnyObject {
    func openNewDateNotification()
    func openNewTimerNotification()
    func openNewLocationNotification()
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
    
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    init(coordinator: MainTabBarCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func addButtonDidTap(sender: UIView) {
        coordinator?.showMenu(sender: sender, delegate: self)
    }
}

extension MainTabBarVM: MenuPopoverDelegate {
    func didSelect(action: MenuPopoverVC.Action) {
        switch action {
        case .calendar: 
            coordinator?.openNewDateNotification()
        case .timer: 
            coordinator?.openNewTimerNotification()
        case .location: 
            coordinator?.openNewLocationNotification()
        default: break
        }
    }
}
