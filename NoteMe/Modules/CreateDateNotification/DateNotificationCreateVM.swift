//
//  DateNotificationCreateVM.swift
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
    func updateOrCreate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

protocol DateNotificationServiceUseCase {
    func makeDateNotification(dto: DateNotificationDTO)
}

protocol DateNotificationFirebaseBackupUseCase {
    func backup(dto: any DTODescription)
}

protocol DateNotificationWorkerUsecase {
    func makeDateNotification(dto: DateNotificationDTO)
}

final class DateNotificationCreateVM {
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    private let worker: DateNotificationWorkerUsecase
    var shouldEditeDTO: ((DateNotificationDTO) -> Void)?
    
    var title: String? { didSet {isValidTitle()} }
    var date: Date? { didSet {isValidDate()} }
    var comment: String?
    
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    init(coordinator: DateNotificationCoordinatorProtocol,
         worker: DateNotificationWorkerUsecase
    ) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func createDidTapped() {
        guard checkValidation() else { return }
        guard let title, let date  else { return }
        let newDTO = DateNotificationDTO(date: Date(),
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
        worker.makeDateNotification(dto: newDTO)
        coordinator?.finish()
    }
}

//MARK: VM protocol
extension DateNotificationCreateVM: DateNotificationViewModelProtocol {
    @discardableResult
    func checkValidation() -> Bool {
        return isValidTitle() && isValidDate()
    }
    
    func viewDidLoad() {}
    
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
private extension DateNotificationCreateVM {
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
