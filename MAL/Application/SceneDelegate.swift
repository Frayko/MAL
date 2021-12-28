//
//  SceneDelegate.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		let myNavigationController = AppNavigationController()
		window.rootViewController = myNavigationController
		self.window = window
		self.window?.makeKeyAndVisible()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}
