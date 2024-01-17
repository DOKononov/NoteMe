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
                   cancelStyle: UIAlertAction.Style? = .cancel,
                   okTitile: String? = nil,
                   okHandler: AlertActionHandler? = nil,
                   okStyle: UIAlertAction.Style? = .default) {
        
        let alertVC = buildAlert(title: title,
                                 message: message,
                                 cancelTitile: cancelTitile,
                                 cancelHandler: cancelHandler,
                                 cancelStyle: cancelStyle,
                                 okTitile: okTitile,
                                 okHandler: okHandler,
                                 okStyle: okStyle)
        
        let window = windowManager.get(type: .alert)
        window.rootViewController = UIViewController()
        windowManager.show(type: .alert)
        window.rootViewController?.present(alertVC, animated: true)
    }
    
    
    private func buildAlert(title: String?,
                            message: String?,
                            cancelTitile: String? = nil,
                            cancelHandler: AlertActionHandler? = nil,
                            cancelStyle: UIAlertAction.Style?,
                            okTitile: String? = nil,
                            okHandler: AlertActionHandler? = nil,
                            okStyle: UIAlertAction.Style?) -> UIAlertController {
        
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        alertVC.setValue(NSAttributedString(
            string: message ?? "",
            attributes: [.foregroundColor: UIColor.appAlertMessage,
                         .font: UIFont.appFont.withSize(14)]),
                         forKey: "attributedMessage")
        
        if let cancelTitile {
            let action = UIAlertAction(title: cancelTitile, style: cancelStyle ?? .cancel) { [weak self] _ in
                cancelHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
            }
            alertVC.addAction(action)
        }
        
        if let okTitile {
            let action = UIAlertAction(title: okTitile, style: okStyle ?? .default) { [weak self] _ in
                okHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
                
            }
            alertVC.addAction(action)
        }
        return alertVC
    }
}

