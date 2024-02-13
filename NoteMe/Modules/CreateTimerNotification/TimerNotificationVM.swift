//
//  TimerNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation
import Storage

protocol TimerNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private let storage: TimerNotificationStorage

    var title: String?
    var timeinterval: Double?
    var comment: String?

    
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    func createDidTapped() {
        
        guard let title, let timeinterval else { return }
        var dto = TimerNotificationDTO(date: Date(),
                                       title: title,
                                       subtitle: comment,
                                       targetDate: Date())
        dto.timeLeft = timeinterval
        storage.create(dto: dto)
    }
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorage) {
        self.coordinator = coordinator
        self.storage = storage
    }
}
