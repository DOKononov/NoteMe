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
    var timeinterval: Double? {  didSet { updateLabel() } }
    var comment: String?
    
    var timeIntervalDidSet: ((String) -> Void)?
    
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    func createDidTapped() {
        
        guard let title, let timeinterval else { return }
        let newDTO = TimerNotificationDTO(date: Date(),
                                          title: title,
                                          subtitle: comment,
                                          targetDate: Date().addingTimeInterval(timeinterval))
        storage.updateOrCreate(dto: newDTO)
        coordinator?.finish()
    }
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorage) {
        self.coordinator = coordinator
        self.storage = storage
    }
    
    private func updateLabel() {
        guard let timeinterval else { return }
        let time = NSInteger(timeinterval)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        timeIntervalDidSet?(String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds))
    }
}
