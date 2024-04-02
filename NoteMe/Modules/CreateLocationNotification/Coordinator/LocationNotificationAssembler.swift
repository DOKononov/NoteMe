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
        
        let storage: LocationNotificationStorage = container.resolve()
        let imageStorage: ImageStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        
        let vm = LocationNotificationCreateVM(
            coordinator: coordinator,
            storage: storage,
            imageStorage: imageStorage, 
            notificationService: notificationService)
        
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
    
    static func makeEdit(_ coordinator: LocationNotificatioCoordinatorProtocol,
                     container: Container,
                     dto: LocationNotificationDTO) -> UIViewController {
        
        let storage: LocationNotificationStorage = container.resolve()
        let imageStorage: ImageStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        
        let vm = LocationNotificationEditVM(
            coordinator: coordinator,
            dto: dto,
            storage: storage,
            imageStorage: imageStorage,
            notificationService: notificationService)
        
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
}
