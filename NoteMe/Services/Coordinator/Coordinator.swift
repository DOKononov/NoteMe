//
//  Coordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

class Coordinator {
    
    var onDidFinish: ((Coordinator) -> Void)?
    var chidren: [Coordinator] = []
    
    func start() -> UIViewController {
        fatalError("Should be overriden")
    }
    
    func finish() {
        onDidFinish?(self)
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        lhs === rhs
    }
}
