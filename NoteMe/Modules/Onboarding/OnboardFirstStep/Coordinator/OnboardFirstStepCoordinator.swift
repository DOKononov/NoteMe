//
//  OnboardFirstStepCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit

final class OnboardFirstStepCoordinator: Coordinator {
    private var rootNC: UINavigationController?
    
    override func start() -> UIViewController {
        let vc = OnboardFirstStepAssembler.make(self)
        let nc = UINavigationController(rootViewController: vc)
        self.rootNC = nc
        return nc
    }
}

//MARK: -OnboardFirstCoordinatorProtocol
extension OnboardFirstStepCoordinator: OnboardFirstCoordinatorProtocol {
    func openNextStep() {
        let coordinator = OnboardSecondStepCoordinator()
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll() { $0 == coordinator }
            self?.finish()
        }
        coordinator.onDismissedByUser = { [weak self] coordinator in
            self?.chidren.removeAll() { $0 == coordinator }
        }
        
        let vc = coordinator.start()
        rootNC?.pushViewController(vc, animated: true)
    }
}
