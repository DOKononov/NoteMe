//
//  DateNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol DateNotificationCoordinatorProtocol: AnyObject {
    
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    
    init(coordinator: DateNotificationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
