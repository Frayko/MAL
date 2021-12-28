//
//  AnimeListAssembly.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

enum AnimeListAssembly
{
	static func build() -> UIViewController {
		let animeStorage = AnimeListDBStorage()
		let network = NetworkService()
		let router = AnimeListRouter()
		let model = AnimeListModel()
		let presenter = AnimeListPresenter(dependecies: .init(model: model,
															  router: router,
															  network: network,
															  animeStorage: animeStorage))
		let controller = AnimeListVC(presenter: presenter)
		return controller
	}
}
