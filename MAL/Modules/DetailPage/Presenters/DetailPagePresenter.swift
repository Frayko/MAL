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
	private let network: INetworkService
	private weak var view: IDetailPageView?
	private weak var controller: IDetailPageVC?
	private var detailAnimesInstance: DetailAnimeStorage
	private let animeInfoURL: String
	private let malID: Int
	
	struct Dependecies {
		let model: IDetailPageModel
		let network: INetworkService
	}
	
	init(dependecies: Dependecies, malID: Int) {
		self.model = dependecies.model
		self.network = dependecies.network
		self.detailAnimesInstance = DetailAnimeStorage.shared
		self.malID = malID
		self.animeInfoURL = "https://api.jikan.moe/v3/anime/\(self.malID)"
	}
}

extension DetailPagePresenter: IDetailPagePresenter {
	func loadView(controller: IDetailPageVC, view: IDetailPageView) {
		self.controller = controller
		self.view = view
		
		self.view?.didLoad()
		
		if self.detailAnimesInstance.has(malID: self.malID) {
			self.setData()
		}
		else {
			self.loadData()
		}
	}
}

private extension DetailPagePresenter {
	func loadData() {
		self.network.loadData(urlString: self.animeInfoURL) { (result: Result<AnimeInfoDTO, Error>) in
			switch result {
			case .success(let animeInfo):
				print("[NETWORK] model is: \(animeInfo)")
				DispatchQueue.main.async {
					self.detailAnimesInstance.append(DetailAnimeModel(malID: animeInfo.malID,
																rank: animeInfo.rank,
																title: animeInfo.title,
																url: animeInfo.url,
																imageURL: animeInfo.imageURL,
																type: animeInfo.type,
																source: animeInfo.source,
																status: animeInfo.status,
																rating: animeInfo.rating,
																synopsis: animeInfo.synopsis,
																episodes: animeInfo.episodes,
																members: animeInfo.members,
																favorites: animeInfo.favorites,
																score: animeInfo.score))
					
					self.setData()
				}
			case .failure(let error):
				print("[NETWORK] error is: \(error)")
				DispatchQueue.main.async {
					print("Загрузка закончена с ошибкой \(error.localizedDescription)")
				}
			}
		}
	}
	
	func setData() {
		let rawData = self.detailAnimesInstance.getAnime(malID: self.malID)
		
		guard let data = rawData else {
			print("No anime from malID - ", self.malID)
			return
		}
		
		self.controller?.navigationItem.title = "\(data.rank) place"
		self.view?.setData(data)
	}
}
