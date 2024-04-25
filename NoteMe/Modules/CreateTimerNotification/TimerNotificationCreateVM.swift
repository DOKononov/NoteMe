//
//  TimerNotificationCreateVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation
import Storage

protocol TimerNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol TimerNotificationWorkerUseCase {
    func createOrUpdate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

final class TimerNotificationCreateVM: TimerNotificationViewModelProtocol {
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private let worker: TimerNotificationWorkerUseCase
    var shouldEditeDTO: ((TimerNotificationDTO) -> Void)?
    var title: String?
    var timeinterval: Double? {  didSet { updateLabel() } }
    var comment: String?
    var timeIntervalDidSet: ((String) -> Void)?
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
    
    func viewDidLoad() {}
    
    func createDidTapped() {
        guard let title, let timeinterval else { return }
        let targetDate = Date().addingTimeInterval(timeinterval)
        let newDTO = TimerNotificationDTO(
            date: Date(),
            title: title,
            subtitle: comment,
            targetDate: targetDate)
        worker.createOrUpdate(dto: newDTO, completion: nil)
        coordinator?.finish()
    }
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         worker: TimerNotificationWorkerUseCase
    ) {
        self.coordinator = coordinator
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
