//
//  LocationNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol LocationNotificatioCoordinatorProtocol: AnyObject {
    func finish()
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol {
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?

    init(coordinator: LocationNotificatioCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}