//
//  DetailPageAssembly.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import UIKit

enum DetailPageAssembly {
	static func build(malID: Int) -> UIViewController {
		let network = NetworkService()
		let model = DetailPageModel()
		let presenter = DetailPagePresenter(dependecies: .init(model: model,
															   network: network),
											malID: malID)
		let controller = DetailPageVC(dependecies: .init(presenter: presenter))
		return controller
	}
}
