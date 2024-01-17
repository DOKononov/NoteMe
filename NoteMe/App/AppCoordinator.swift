//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let container: Container
    private let windowManager: WindowManager
    
    init(container: Container) {
        self.container = container
        self.windowManager = container.resolve()
    }
    
     func startApp() {
         if ParametersHelper.get(.authenticated) {
             //open unboarding or mainApp
             if ParametersHelper.get(.unbordered) {
                 //open main
                 openMainApp()
             } else {
                 openOnboardingModule()
             }
         } else {
             openAuthModule()
         }
    }

    private func openAuthModule() {
        let coordinator = LoginCoordinator(container: container)
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openOnboardingModule() {
       let coordinator = OnboardFirstStepCoordinator()
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openMainApp() {
        let coordinator = MainTabBarCoordinator(container: container)
        chidren.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
}


