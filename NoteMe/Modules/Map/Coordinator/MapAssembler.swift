//
//  MapAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.03.24.
//

import UIKit
import MapKit

final class MapAssembler {
    private init() {}
    
    static func make(_ coordinator: MapCoordinatorProtocol,
                     container: Container,
                     delegate: MapModuleDelegate?,
                     region: MKCoordinateRegion?
    ) -> UIViewController {
        let locationNetworkService: LocationNetworkService = container.resolve()
        let adapter = MapAdapter()
        let vm = MapVM(coordinator: coordinator,
                       delegate: delegate,
                       region: region,
                       locationNetworkService: locationNetworkService,
                       adapter: adapter)
        let vc = MapVC(viewmodel: vm)
        return vc
    }
}
