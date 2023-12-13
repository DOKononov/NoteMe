//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit


final class HomeCoordinator: Coordinator {
    override func start() -> UIViewController {
        return HomeAssembler.make()
    }
}
