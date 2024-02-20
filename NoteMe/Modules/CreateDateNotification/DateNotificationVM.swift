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

protocol DateNotificationStorageUseCase {
    func create(_ dto: DateNotificationDTO, completion: ((Bool) -> Void)?)
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    private let storage: DateNotificationStorage //UseCase
    var dto: DateNotificationDTO?
    var shouldEditeDTO: ((DateNotificationDTO) -> Void)?
    
    var title: String? { didSet {isValidTitle()} }
    var date: Date? { didSet {isValidDate()} }
    var comment: String?
    
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    init(coordinator: DateNotificationCoordinatorProtocol,
         storage: DateNotificationStorage, //UseCase
         dto: DateNotificationDTO?
    ) {
        self.coordinator = coordinator
        self.storage = storage
        self.dto = dto
    }
    
    func createDidTapped() {
        guard checkValidation() else { return }
        guard let title, let date  else { return }
        let newDTO = DateNotificationDTO(date: Date(),
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
        dto?.title = title
        dto?.targetDate = date
        dto?.subtitle = comment
        storage.updateOrCreate(dto: dto ?? newDTO)
        coordinator?.finish()
    }
    
    func string(from date: Date?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date else { return nil}
        return dateFormatter.string(from: date)
    }
    
    func viewDidLoad() {
        guard let dto else { return }
        shouldEditeDTO?(dto)
    }
    
    func dismissDidTapped() {
        coordinator?.finish()
    }
}

//MARK: -private methods
private extension DateNotificationVM {
    @discardableResult
    func checkValidation() -> Bool {
        return isValidTitle() && isValidDate()
    }
    
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
            let date
        else {
            catchDateError?(.Notification.enter_date)
            return false
        }
        return true
    }
}
