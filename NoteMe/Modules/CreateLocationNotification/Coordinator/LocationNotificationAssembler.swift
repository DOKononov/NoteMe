//
//  LocationNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit


final class LocationNotificationAssembler {
    private init() {}
    
    static func make(_ coordinator: LocationNotificatioCoordinatorProtocol) -> UIViewController {
        let vm = LocationNotificationVM(coordinator: coordinator)
        let vc = LocationNotificationVC(viewModel: vm)
        return vc
    }
}
