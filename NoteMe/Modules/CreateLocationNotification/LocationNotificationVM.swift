//
//  LocationNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation

protocol LocationNotificatioCoordinatorProtocol: AnyObject {}

final class LocationNotificationVM: LocationNotificationViewModelProtocol {
    
    private weak var coordinator: LocationNotificatioCoordinatorProtocol?

    init(coordinator: LocationNotificatioCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
