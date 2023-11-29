//
//  OnboardSecondStepVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

protocol OnboardSecondStepCoordinatorProtocol: AnyObject {
    func finish()
    func dismissedByUser()
}

final class OnboardSecondStepVM {
    private weak var coordinator: OnboardSecondStepCoordinatorProtocol?
    
    init(coordinator: OnboardSecondStepCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

//MARK: -OnboardSecondStepViewModelProtocol
extension OnboardSecondStepVM: OnboardSecondStepViewModelProtocol {
    func doneDidTap() {
        coordinator?.finish()
    }
    
    func dismissedByUser() {
        coordinator?.dismissedByUser()
    }
}
