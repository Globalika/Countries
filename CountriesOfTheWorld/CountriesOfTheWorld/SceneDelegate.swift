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

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = .white

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let networkManager = NetworkManager(client: Apollo())

        let mainController = CountriesController(networkManager)
        let mainNC = UINavigationController(rootViewController: mainController)

        let detailController = CountryDetailsController(networkManager)
        let detailNC = UINavigationController(rootViewController: detailController)

        let splitViewController =  UISplitViewController()
        splitViewController.viewControllers = [mainNC, detailNC]

        splitViewController.delegate = self
        splitViewController.view.backgroundColor = .white

        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
