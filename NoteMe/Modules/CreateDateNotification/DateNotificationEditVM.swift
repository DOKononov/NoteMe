//
//  DateNotificationEditVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.04.24.
//

import Foundation
import Storage


final class DateNotificationEditVM {
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    var dto: DateNotificationDTO
    private let worker: DateNotificationWorkerUsecase
    var shouldEditeDTO: ((DateNotificationDTO) -> Void)?
    
    var title: String? { didSet {isValidTitle()} }
    var date: Date? { didSet {isValidDate()} }
    var comment: String?
    
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    init(coordinator: DateNotificationCoordinatorProtocol,
         worker: DateNotificationWorkerUsecase,
         dto: DateNotificationDTO
    ) {
        self.coordinator = coordinator
        self.worker = worker
        self.dto = dto
    }
    
    func createDidTapped() {
        guard checkValidation() else { return }
        guard let title, let date  else { return }
        dto.title = title
        dto.targetDate = date
        dto.subtitle = comment
        worker.makeDateNotification(dto: dto)
        coordinator?.finish()
    }
}

//MARK: VM protocol
extension DateNotificationEditVM: DateNotificationViewModelProtocol {
    @discardableResult
    func checkValidation() -> Bool {
        return isValidTitle() && isValidDate()
    }
    
    func viewDidLoad() {
        shouldEditeDTO?(dto)
    }
    
    func string(from date: Date?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date else { return nil}
        return dateFormatter.string(from: date)
    }
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
}

//MARK: -private methods
private extension DateNotificationEditVM {
    @discardableResult
    func isValidTitle() -> Bool {
        guard
            let title,
            !title.isEmpty,
            title != ""
        else {
            catchTitleError?(.Notification.enter_title)
            return false
        }
        catchTitleError?(nil)
        return true
    }
    
    @discardableResult
    func isValidDate() -> Bool {
        guard
             date != nil
        else {
            catchDateError?(.Notification.enter_date)
            return false
        }
        return true
    }
}
