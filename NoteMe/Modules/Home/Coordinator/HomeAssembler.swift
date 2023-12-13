//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class HomeAssembler {
    private init() {}
        
    static func make() -> UIViewController {
        let viewModel = HomeVM()

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
}
