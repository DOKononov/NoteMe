//
//  OnboardFirstStepVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

protocol OnboardFirstCoordinatorProtocol: AnyObject {
    func openNextStep()
}

final class OnboardFirstStepVM {
    private weak var coordinator: OnboardFirstCoordinatorProtocol?
    
    init(coordinator: OnboardFirstCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

//MARK: -OnboardFirstStepViewModelProtocol
extension OnboardFirstStepVM: OnboardFirstStepViewModelProtocol {
    func nextDidTap() {
        coordinator?.openNextStep()
    }
}




