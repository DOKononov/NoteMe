//
//  OnboardFirstStepAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

final class OnboardFirstStepAssembler {
    private init() {}
    
    static func make(_ coordinator: OnboardFirstCoordinatorProtocol) -> UIViewController {
        let vm = OnboardFirstStepVM(coordinator: coordinator)
        return OnboardFirstStepVC(viewModel: vm)
    }
}
