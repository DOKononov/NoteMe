//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class HomeAssembler {
    private init() {}
        
    static func make(coordinator: HomeCoordinatorProtocol,
                     container: Container
    ) -> UIViewController {
        let adapter = HomeAdapter()
        
        let viewModel = HomeVM(adapter: adapter)

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
}
