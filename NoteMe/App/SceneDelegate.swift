//
//  SceneDelegate.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let container = ContainerRegistrator.makeContainer()
        container.register({WindowManager(scene: windowScene)})
        appCoordinator = AppCoordinator(container: container)
        appCoordinator?.startApp()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

