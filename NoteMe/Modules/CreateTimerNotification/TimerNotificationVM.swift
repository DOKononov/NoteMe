//
//  TimerNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol TimerNotificationCoordinatorProtocol: AnyObject {}

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    
    init(coordinator: TimerNotificationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
