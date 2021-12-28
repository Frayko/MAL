//
//  DetailPagePresenter.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import UIKit

protocol IDetailPagePresenter {
	func loadView(controller: IDetailPageVC, view: IDetailPageView)
}

final class DetailPagePresenter {
	private let model: IDetailPageModel
	private weak var view: IDetailPageView?
	private weak var controller: IDetailPageVC?
	private var detailAnimesInstance: DetailAnimeStorage
	private let malID: Int
	
	struct Dependecies {
		let model: IDetailPageModel
	}
	
	init(dependecies: Dependecies, malID: Int) {
		self.model = dependecies.model
		self.detailAnimesInstance = DetailAnimeStorage.shared
		self.malID = malID
	}
}

extension DetailPagePresenter: IDetailPagePresenter {
	func loadView(controller: IDetailPageVC, view: IDetailPageView) {
		self.controller = controller
		self.view = view
		
		self.view?.didLoad()
		
		self.setData()
	}
}

private extension DetailPagePresenter {
	func setData() {
		let rawData = self.detailAnimesInstance.getAnime(malID: self.malID)
		
		guard let data = rawData else {
			print("Не загрузили malID - ", self.malID)
			return
		}
		
		self.controller?.navigationItem.title = "\(data.rank) place"
		self.view?.setData(data)
		//let modelViewAnime = self.model.getAnime()
		
		//self.view?.setData(modelViewAnime)
	}
}
