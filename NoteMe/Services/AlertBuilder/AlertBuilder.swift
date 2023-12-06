//
//  AlertBuilder.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 5.12.23.
//

import UIKit

final class AlertBuilder {
    typealias AlertActionHandler = () -> Void
    
    static func build(title: String?,
                      message: String?,
                      cancelTitile: String? = nil,
                      cancelHandler: AlertActionHandler? = nil,
                      okTitile: String? = nil,
                      okHandler: AlertActionHandler? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancelTitile {
            let action = UIAlertAction(title: cancelTitile, style: .cancel) { _ in
                cancelHandler?()
            }
            alertVC.addAction(action)
        }
      
        if let okTitile {
            let action = UIAlertAction(title: okTitile, style: .default) { _ in
                okHandler?()
            }
            alertVC.addAction(action)
        }
        return alertVC
    }
}
