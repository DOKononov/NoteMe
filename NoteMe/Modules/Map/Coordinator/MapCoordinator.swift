//
//  MapCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 6.03.24.
//

import UIKit
import MapKit

final class MapCoordinator: Coordinator, MapCoordinatorProtocol {
    
    private let container: Container
    private weak var delegate: MapModuleDelegate?
    private let region: MKCoordinateRegion?
    
    init(container: Container, 
         delegate: MapModuleDelegate?,
         region: MKCoordinateRegion?
    ) {
        self.container = container
        self.delegate = delegate
        self.region = region
    }
    
    override func start() -> UIViewController {
        let vc =  MapAssembler.make(self, container: container, 
                                    delegate: delegate,
                                    region: region
        )
        return vc
    }
}
