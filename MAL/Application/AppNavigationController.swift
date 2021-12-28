//
//  AppNavigationController.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

final class AppNavigationController: UINavigationController
{
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationController()
		configureView()
	}
}

private extension AppNavigationController
{
	func configureNavigationController() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .systemBackground
		self.navigationBar.standardAppearance = appearance
		self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
		
		self.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.circle.fill")
		self.navigationBar.tintColor = .systemTeal
		self.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.circle.fill")
	}
	
	func configureView() {
		let animeList = AnimeListAssembly.build()
		self.setViewControllers([animeList], animated: true)
	}
}

