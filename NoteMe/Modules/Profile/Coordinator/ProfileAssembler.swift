//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

final class ProfileAssembler {
    private init() {}
    
    static func make(_ coordinator: ProfileCoordinatorProtocol,
                     container: Container) -> UIViewController {
        let authService: AuthService = container.resolve()
        let alertService: AlertService = container.resolve()
        let viewModel = ProfileVM(authService: authService,
                                  coordinator: coordinator,
                                  alertService: alertService)
        let vc = ProfileVC(viewModel: viewModel)
        return vc
    }
}
