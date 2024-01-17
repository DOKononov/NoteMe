//
//  RegisterCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    private let contianer: Container
    
    init(contianer: Container) {
        self.contianer = contianer
    }
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(coordinator: self, container: contianer)
    }
}

//MARK: -RegisterCoordinatorProtocol
extension RegisterCoordinator: RegisterCoordinatorProtocol {}
