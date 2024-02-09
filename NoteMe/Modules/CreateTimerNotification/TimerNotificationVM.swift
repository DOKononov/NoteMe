//
//  TimerNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol TimerNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    
    init(coordinator: TimerNotificationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
