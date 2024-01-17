//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }

    override func start() -> UIViewController {
        let vc = ProfileAssembler.make(self, container: container)
        rootVC = vc
        return vc
    }
}

//MARK: -ProfileCoordinatorProtocol
extension ProfileCoordinator: ProfileCoordinatorProtocol {}
