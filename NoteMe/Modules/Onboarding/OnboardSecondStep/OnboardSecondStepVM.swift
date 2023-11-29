//
//  OnboardSecondStepVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

protocol OnboardingTextFormatterUseCase {
    func setAttributes(to string: String) -> NSAttributedString
}

protocol OnboardSecondStepCoordinatorProtocol: AnyObject {
    func finish()
    func dismissedByUser()
}

final class OnboardSecondStepVM {
    private weak var coordinator: OnboardSecondStepCoordinatorProtocol?
    private let textFormatter: OnboardingTextFormatterUseCase
    
    init(coordinator: OnboardSecondStepCoordinatorProtocol,
         textFormatter: OnboardingTextFormatterUseCase) {
        self.coordinator = coordinator
        self.textFormatter = textFormatter
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
    
    func setAttributes(to string: String) -> NSAttributedString {
        textFormatter.setAttributes(to: string)
    }
}
