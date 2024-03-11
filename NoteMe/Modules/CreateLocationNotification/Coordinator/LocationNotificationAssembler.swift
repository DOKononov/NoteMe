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
                     dto: LocationNotificationDTO?) -> UIViewController {
        let vm = LocationNotificationVM(coordinator: coordinator, dto: dto)
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
}
