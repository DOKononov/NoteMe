//
//  AlertService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class AlertService {
    typealias AlertActionHandler = () -> Void
    
    private let windowManager: WindowManager
    
    init(container: Container) {
        self.windowManager = container.resolve()
    }
    
    func showAlert(title: String?,
                   message: String?,
                   cancelTitile: String? = nil,
                   cancelHandler: AlertActionHandler? = nil,
                   okTitile: String? = nil,
                   okHandler: AlertActionHandler? = nil) {
        
        let alertVC = buildAlert(title: title,
                                 message: message,
                                 cancelTitile: cancelTitile,
                                 cancelHandler: cancelHandler,
                                 okTitile: okTitile,
                                 okHandler: okHandler)
        
        let window = windowManager.get(type: .alert)
        window.rootViewController = UIViewController()
        windowManager.show(type: .alert)
        window.rootViewController?.present(alertVC, animated: true)
    }
    
    
    private func buildAlert(title: String?,
                            message: String?,
                            cancelTitile: String? = nil,
                            cancelHandler: AlertActionHandler? = nil,
                            okTitile: String? = nil,
                            okHandler: AlertActionHandler? = nil) -> UIAlertController {
        
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        if let cancelTitile {
            let action = UIAlertAction(title: cancelTitile, style: .cancel) { [weak self] _ in
                cancelHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
            }
            alertVC.addAction(action)
        }
        
        if let okTitile {
            let action = UIAlertAction(title: okTitile, style: .default) { [weak self] _ in
                okHandler?()
                self?.windowManager.hideAndRemove(type: .alert)

            }
            alertVC.addAction(action)
        }
        return alertVC
    }
}

