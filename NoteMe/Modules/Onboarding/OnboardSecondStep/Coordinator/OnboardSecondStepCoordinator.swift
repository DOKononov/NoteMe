//
//  OnboardSecondStepCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

final class OnboardSecondStepCoordinator: Coordinator {
    
    var onDismissedByUser: ((Coordinator) -> Void)?
    
    override func start() -> UIViewController {
        return OnboardSecondStepAssembler.make(self)
    }
}

//MARK: -OnboardSecondStepCoordinatorProtocol
extension OnboardSecondStepCoordinator: OnboardSecondStepCoordinatorProtocol {
    func dismissedByUser() {
        onDismissedByUser?(self)
    }
}

/*
//TODO
дон = открыть таббар с двумя экранами
  */
