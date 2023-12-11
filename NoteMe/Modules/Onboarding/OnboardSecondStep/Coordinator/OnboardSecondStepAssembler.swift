//
//  OnboardSecondStepAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

final class OnboardSecondStepAssembler {
    private init () {}
    
    static func make(_ coordinator: OnboardSecondStepCoordinatorProtocol) -> UIViewController {
        let vm = OnboardSecondStepVM(coordinator: coordinator)
        let vc = OnboardSecondStepVC(viewModel: vm)
        return vc
    }
}
