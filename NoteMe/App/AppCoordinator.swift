//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    private var window: UIWindow
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
    
     func startApp() {
//         ParametersHelper.set(.authenticated, value: false)
         if ParametersHelper.get(.authenticated) {
             //open unboarding or mainApp
             openOnboardingModule()
         } else {
             openAuthModule()
         }
    }

    private func openAuthModule() {
        let coordinator = LoginCoordinator()
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openOnboardingModule() {
       let coordinator = OnboardFirstStepCoordinator()
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}


