//
//  SceneDelegate.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let tabBarController = TabBarController()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow( frame : windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

