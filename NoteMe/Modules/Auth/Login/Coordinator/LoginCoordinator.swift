//
//  LoginCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }

    override func start() -> UIViewController {
        let vc  = LoginAssembler.make(container: container, coordinator: self)
        rootVC = vc
        return vc
    }
}

//MARK: -LoginCoordinatorProtocol
extension LoginCoordinator: LoginCoordinatorProtocol {
    
    func openRegisterModule() {
        let coodinator = RegisterCoordinator(contianer: container)
        chidren.append(coodinator)
        let vc = coodinator.start()
        
        coodinator.onDidFinish = { [weak self] cordinator in
            self?.chidren.removeAll { coodinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        rootVC?.present(vc, animated: true)
    }
    
    func openResetPasswordModule() {
        let coordinator = ResetPasswordCoordinator(container: container)
        chidren.append(coordinator)
        let vc = coordinator.start()

        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { $0 == coordinator }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
}
