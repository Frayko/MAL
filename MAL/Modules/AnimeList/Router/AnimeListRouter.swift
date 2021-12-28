//
//  AnimeListRouter.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation

protocol IAnimeListRouter
{
	func setPushControllerHandler(_ handler: @escaping ((_ malID: Int) -> Void))
	func goToDetailPage(malID: Int)
}

final class AnimeListRouter
{
	private var goToDetailPageHandler: ((_ malID: Int) -> Void)?
}

extension AnimeListRouter: IAnimeListRouter
{
	func setPushControllerHandler(_ handler: @escaping ((Int) -> Void)) {
		self.goToDetailPageHandler = handler
	}
	
	func goToDetailPage(malID: Int) {
		self.goToDetailPageHandler?(malID)
	}
}
