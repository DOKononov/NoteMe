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

    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    private let storage: DateNotificationStorage
    
    init(coordinator: DateNotificationCoordinatorProtocol,
         storage: DateNotificationStorage
    ) {
        self.coordinator = coordinator
        self.storage = storage
    }
    
    func createDidTapped(title: String?, date: Date?, comment: String?) {
        guard checkValidation(title: title, date: date) else { return }
        guard let title, let date  else { return }
         let dto = DateNotificationDTO(date: Date(),
                                       title: title,
                                       subtitle: comment,
                                       targetDate: date)
        storage.create(dto: dto)
        coordinator?.finish()
    }
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
}

//MARK: -private methods
private extension DateNotificationVM {
    func checkValidation(title: String?, date: Date?) -> Bool {
        catchTitleError?(isValid(title) ? nil : "ERROR")
        catchDateError?(isValid(date) ? nil: "ERROR")
        return isValid(title) && isValid(date)
    }
    
    func isValid(_ title: String?) -> Bool {
        if let title {
            return !title.isEmpty
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
