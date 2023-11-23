//
//  RegisterCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(coordinator: self)
    }
}

//MARK: -RegisterCoordinatorProtocol
extension RegisterCoordinator: RegisterCoordinatorProtocol {}
