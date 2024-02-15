//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit


final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    private let container: Container
    init(container: Container) {
        self.container = container
    }
    override func start() -> UIViewController {
        return HomeAssembler.make(coordinator: self, container: container)
    }
}
