//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

final class ProfileAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let viewModel = ProfileVM()
        
        let vc = ProfileVC(viewModel: viewModel)
        return vc
    }
}
