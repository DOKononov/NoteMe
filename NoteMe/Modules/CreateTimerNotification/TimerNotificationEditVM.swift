//
//  TimerNotificationEditVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.04.24.
//

import Foundation
import Storage

final class TimerNotificationEditVM: TimerNotificationViewModelProtocol {
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private let worker: TimerNotificationWorkerUseCase
    var dto: TimerNotificationDTO
    var shouldEditeDTO: ((TimerNotificationDTO) -> Void)?
    var title: String?
    var timeinterval: Double? {  didSet { updateLabel() } }
    var comment: String?
    
    var timeIntervalDidSet: ((String) -> Void)?
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    func viewDidLoad() {
        shouldEditeDTO?(dto)
    }
    
    func createDidTapped() {
        guard let title, let timeinterval else { return }

        dto.title = title
        dto.subtitle = comment
        dto.timeLeft = timeinterval
        worker.makeTimerNotification(dto: dto)
        coordinator?.finish()
    }
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         dto: TimerNotificationDTO,
         worker: TimerNotificationWorkerUseCase
    ) {
        self.coordinator = coordinator
        self.dto = dto
        self.worker = worker
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

