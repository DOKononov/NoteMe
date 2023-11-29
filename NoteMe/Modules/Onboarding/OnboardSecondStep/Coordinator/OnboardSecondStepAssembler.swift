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
        let textFormatter = TextFormatter()
        let vm = OnboardSecondStepVM(coordinator: coordinator,
                                     textFormatter: textFormatter)
        let vc = OnboardSecondStepVC(viewModel: vm)
        return vc
    }
}
