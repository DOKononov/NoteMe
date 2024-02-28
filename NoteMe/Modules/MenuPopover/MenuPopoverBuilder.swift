//
//  MenuPopoverBuilder.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 27.02.24.
//

import UIKit

final class MenuPopoverBuilder {
    private init() {}
    
    static func buildAddMenu(delegate: MenuPopoverDelegate, sourceView: UIView) -> UIViewController {
        return build(delegate: delegate, actions: [.calendar, .location, .timer], sourceView: sourceView)
    }
    
    static func buildEditeenu(delegate: MenuPopoverDelegate, sourceView: UIView) -> UIViewController {
        let menu =  build(delegate: delegate, actions: [.edite, .delete], sourceView: sourceView)
        menu.popoverPresentationController?.permittedArrowDirections = .up
        return menu
    }
    
    private static func build(delegate: MenuPopoverDelegate, actions: [MenuPopoverVC.Action], sourceView: UIView) -> UIViewController {
        let adapter = MenuPopoverAdapter(actions: actions)
        let vc =  MenuPopoverVC(delegate: delegate, adapter: adapter, sourceView: sourceView)
        return vc
    }
}
