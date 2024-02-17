//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit
import Storage

final class HomeAssembler {
    private init() {}
        
    static func make(coordinator: HomeCoordinatorProtocol,
                     container: Container
    ) -> UIViewController {
        let adapter = HomeAdapter()
        let storage = DateNotificationStorage() //TODO: !
        let viewModel = HomeVM(adapter: adapter,storage: storage)

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
}
