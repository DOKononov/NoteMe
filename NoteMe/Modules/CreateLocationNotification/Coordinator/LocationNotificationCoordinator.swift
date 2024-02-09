//
//  LocationNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

final class LocationNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = LocationNotificationAssembler.make(self)
        rootVC = vc
        return vc
    }
}

extension LocationNotificationCoordinator: LocationNotificatioCoordinatorProtocol {
    
}
