//
//  NotificationsMapVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import Foundation



protocol NotificationsMapCoordinatorProtocol {
    func finish()
}

final class NotificationsMapVM: NotificationsMapViewModelProtocol {
    func dismissDidTap() {
        coordinator.finish()
    }
    
    private let coordinator: NotificationsMapCoordinatorProtocol
    
    init(coordinator: NotificationsMapCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
