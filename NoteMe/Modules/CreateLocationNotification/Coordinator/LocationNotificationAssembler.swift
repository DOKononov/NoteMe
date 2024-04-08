//
//  LocationNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage


final class LocationNotificationAssembler {
    private init() {}
    
    static func makeCreate(_ coordinator: LocationNotificatioCoordinatorProtocol,
                     container: Container) -> UIViewController {
        let worker: NotificationWorker = container.resolve()
        
        let vm = LocationNotificationCreateVM(
            coordinator: coordinator,
            worker: worker)
        
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
    
    static func makeEdit(_ coordinator: LocationNotificatioCoordinatorProtocol,
                     container: Container,
                     dto: LocationNotificationDTO) -> UIViewController {
        
        let imageStorage: ImageStorage = container.resolve()
        let worker: NotificationWorker = container.resolve()
        
        let vm = LocationNotificationEditVM(
            coordinator: coordinator,
            dto: dto,
            imageStorage: imageStorage,
            worker: worker)
        
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
}
