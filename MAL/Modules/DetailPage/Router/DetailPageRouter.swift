//
//  DetailPageRouter.swift
//  MAL
//
//  Created by Александр Фомин on 03.01.2022.
//

import Foundation

protocol IDetailPageRouter
{
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String,
															   _ message: String,
															   _ popViewController: Bool) -> Void))
	func goToShowAlertMessage(title: String, message: String, popViewController: Bool)
}

final class DetailPageRouter
{
	private var goToShowAlertMessageHandler: ((_ title: String,
											   _ message: String,
											   _ popViewController: Bool) -> Void)?
}

extension DetailPageRouter: IDetailPageRouter
{
	func setGoToShowAlertMessageHandler(_ handler: @escaping ((_ title: String,
															   _ message: String,
															   _ popViewController: Bool) -> Void)) {
		self.goToShowAlertMessageHandler = handler
	}
	
	func goToShowAlertMessage(title: String, message: String, popViewController: Bool) {
		self.goToShowAlertMessageHandler?(title, message, popViewController)
	}
}
