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
    
    static func make(_ coordinator: LocationNotificatioCoordinatorProtocol,
                     container: Container,
                     dto: LocationNotificationDTO?) -> UIViewController {
        
        let storage: LocationNotificationStorage = container.resolve()
        let imageStorage: ImageStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        
        let vm = LocationNotificationVM(
            coordinator: coordinator,
            dto: dto,
            storage: storage,
            imageStorage: imageStorage, 
            notificationService: notificationService)
        
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
}
