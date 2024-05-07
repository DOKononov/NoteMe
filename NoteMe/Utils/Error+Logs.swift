//
//  Error+Logs.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 7.05.24.
//

import Foundation

extension Error {
    
    func log(root: String? = nil) {
        let finalRoot = root ?? "\(Self.self)"
        print("[\(finalRoot)]", localizedDescription)
    }
}
