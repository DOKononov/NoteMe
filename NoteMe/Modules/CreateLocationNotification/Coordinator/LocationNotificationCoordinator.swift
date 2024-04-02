//
//  LocationNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage
import MapKit

final class LocationNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?
    private var container: Container
    private let dto: LocationNotificationDTO?
    
    init(container: Container,
         dto: LocationNotificationDTO?
    ) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        
        if let dto {
            let vc = LocationNotificationAssembler.makeEdit(self,
                                                            container: container,
                                                            dto: dto)
            rootVC = vc
            return vc
        } else {
            let vc = LocationNotificationAssembler.makeCreate(self,
                                                              container: container)
            rootVC = vc
            return vc
        }
        
    }
}

extension LocationNotificationCoordinator: LocationNotificatioCoordinatorProtocol {
    func openMapModule(delegate: MapModuleDelegate?,
                       region: MKCoordinateRegion?
    ) {
        let coordinator = MapCoordinator(
            container: container,
            delegate: delegate,
            region: region)
        
        chidren.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
}
