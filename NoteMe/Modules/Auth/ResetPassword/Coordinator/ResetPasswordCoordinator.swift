//
//  ResetPasswordCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.11.23.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    override func start() -> UIViewController {
        return ResetPasswordAssambler.make(self)
    }
}


extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {}

