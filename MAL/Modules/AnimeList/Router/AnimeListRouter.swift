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
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String,
															   _ message: String,
															   _ popViewController: Bool) -> Void))
	func goToShowAlertMessage(title: String, message: String, popViewController: Bool)
}

final class AnimeListRouter
{
	private var goToDetailPageHandler: ((_ malID: Int) -> Void)?
	private var goToShowAlertMessageHandler: ((_ title: String,
											   _ message: String,
											   _ popViewController: Bool) -> Void)?
}

extension AnimeListRouter: IAnimeListRouter
{
	func setPushControllerHandler(_ handler: @escaping ((Int) -> Void)) {
		self.goToDetailPageHandler = handler
	}
	
	func goToDetailPage(malID: Int) {
		self.goToDetailPageHandler?(malID)
	}
	
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String,
															   _ message: String,
															   _ popViewController: Bool) -> Void)) {
		self.goToShowAlertMessageHandler = handler
	}
	
	func goToShowAlertMessage(title: String, message: String, popViewController: Bool) {
		self.goToShowAlertMessageHandler?(title, message, popViewController)
	}
}
