//
//  DateNotificationVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import Foundation
import Storage

protocol DateNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    private let storage: DateNotificationStorage
    
    var title: String? { didSet {checkValidation()} }
    var date: Date? { didSet {checkValidation()} }
    var comment: String?

    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    
    init(coordinator: DateNotificationCoordinatorProtocol,
         storage: DateNotificationStorage
    ) {
        self.coordinator = coordinator
        self.storage = storage
    }
    
    func createDidTapped() {
        guard checkValidation() else { return }
        guard let title, let date  else { return }
         let dto = DateNotificationDTO(date: Date(),
                                       title: title,
                                       subtitle: comment,
                                       targetDate: date)
        storage.create(dto: dto)
        coordinator?.finish()
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
private extension DateNotificationVM {
    @discardableResult
    func checkValidation() -> Bool {
        catchTitleError?(isValid(title) ? nil : .DateNotification.enterTitle)
        catchDateError?(isValid(date) ? nil: .DateNotification.enterDate)
        return isValid(title) && isValid(date)
    }
    
    func isValid(_ title: String?) -> Bool {
        if let title {
            return (!title.isEmpty) && (title != "")
        } else {
            return false
        }
    }
    
    func isValid(_ date: Date?) -> Bool {
         date != nil
    }
    
    func passwordValidation(password: String?) -> Bool {
        guard let password else { return false }
        return password.isEmpty ? false : true
    }
}
