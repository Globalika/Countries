//
//  SceneDelegate.swift
//  Countries
//
//  Created by Volodymyr Seredovych on 23.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        window?.rootViewController = UINavigationController(rootViewController: CountriesController())
        window?.makeKeyAndVisible()
    }
}
