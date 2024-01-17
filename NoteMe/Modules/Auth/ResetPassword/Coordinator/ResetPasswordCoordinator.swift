//
//  ResetPasswordCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.11.23.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc =  ResetPasswordAssambler.make(self,container: container)
        rootVC = vc
        return vc
    }
}


extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {
    func showAlert(_ alert: UIAlertController) {
        rootVC?.present(alert, animated: true)
    }
}

