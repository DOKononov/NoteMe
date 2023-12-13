//
//  AlertService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class AlertService {
    typealias AlertActionHandler = () -> Void
    static var current: AlertService = .init()
    
    fileprivate var window: UIWindow?
    
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
        buildWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController?.present(alertVC, animated: true)
    }
    
    
    fileprivate func buildWindow() {
        guard let scene = AppCoordinator.windowScene else { return }
        self.window = UIWindow(windowScene: scene) //TODO: remove scene
        self.window?.windowLevel = .alert
        self.window?.rootViewController = UIViewController()
    }
    
    private func removeWindow() {
        self.window?.resignKey()
        self.window = nil
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
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        
        if let okTitile {
            let action = UIAlertAction(title: okTitile, style: .default) { [weak self] _ in
                okHandler?()
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        return alertVC
    }
}



extension UIAlertController {
    
    func show() {
        let alertService = AlertService.current
        alertService.buildWindow()
        alertService.window?.makeKeyAndVisible()
        alertService.window?.rootViewController?.present(self, animated: true)
    }
}
