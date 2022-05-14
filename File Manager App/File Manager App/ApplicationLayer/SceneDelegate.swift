//
//  SceneDelegate.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        IQKeyboardManager.shared.enable = true
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        window = UIWindow(windowScene: windowScene)
        
        let navigationController: UINavigationController = .init()
        
        appCoordinator = AppCoordinator(navigationController)
        
        appCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
