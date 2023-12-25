//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var rootVC: UIViewController?

    override func start() -> UIViewController {
        let vc = ProfileAssembler.make(self)
        rootVC = vc
        return vc
    }
}

//MARK: -ProfileCoordinatorProtocol
extension ProfileCoordinator: ProfileCoordinatorProtocol {}
