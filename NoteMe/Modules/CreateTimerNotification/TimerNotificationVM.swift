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

protocol TimerNotificationStorageUseCase {
    func updateOrCreate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

protocol TimerNotificationServiceUseCase {
    func makeTimerNotification(dto: TimerNotificationDTO)
}

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private let storage: TimerNotificationStorageUseCase
    private let notificationService: TimerNotificationServiceUseCase
    var dto: TimerNotificationDTO?
    var shouldEditeDTO: ((TimerNotificationDTO) -> Void)?
    
    var title: String?
    var timeinterval: Double? {  didSet { updateLabel() } }
    var comment: String?
    
    var timeIntervalDidSet: ((String) -> Void)?
    
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    func viewDidLoad() {
        guard let dto else { return }
        shouldEditeDTO?(dto)
    }
    
    func createDidTapped() {
        guard let title, let timeinterval else { return }
        let newDTO = TimerNotificationDTO(date: Date(),
                                          title: title,
                                          subtitle: comment,
                                          targetDate: Date().addingTimeInterval(timeinterval))
        dto?.title = title
        dto?.subtitle = comment
        dto?.timeLeft = timeinterval
        
        storage.updateOrCreate(dto: dto ?? newDTO, completion: nil)
        notificationService.makeTimerNotification(dto: dto ?? newDTO)
        coordinator?.finish()
    }
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorageUseCase,
         notificationService: TimerNotificationServiceUseCase,
         dto: TimerNotificationDTO?
    ) {
        self.coordinator = coordinator
        self.storage = storage
        self.notificationService = notificationService
        self.dto = dto
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
