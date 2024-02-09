//
//  DateNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol DateNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    
    init(coordinator: DateNotificationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
