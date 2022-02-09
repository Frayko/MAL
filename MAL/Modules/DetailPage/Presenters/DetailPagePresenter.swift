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
	private let router: IDetailPageRouter
	private weak var view: IDetailPageView?
	private weak var controller: IDetailPageVC?
	private var detailAnimesInstance: DetailAnimeStorage
	private let animeInfoURL: String
	private let malID: Int
	private var countRequests: Int
	
	struct Dependecies {
		let model: IDetailPageModel
		let network: INetworkService
		let router: IDetailPageRouter
	}
	
	init(dependecies: Dependecies, malID: Int) {
		self.model = dependecies.model
		self.network = dependecies.network
		self.router = dependecies.router
		self.detailAnimesInstance = DetailAnimeStorage.shared
		self.malID = malID
		self.animeInfoURL = "https://api.jikan.moe/v4/anime/\(self.malID)"
		self.countRequests = 0
	}
}

extension DetailPagePresenter: IDetailPagePresenter {
	func loadView(controller: IDetailPageVC, view: IDetailPageView) {
		self.controller = controller
		self.view = view
		
		self.view?.didLoad()
		self.setHandlers()
		
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
		DispatchQueue.main.async {
			self.view?.showActivityIndicator()
		}
		self.network.loadData(urlString: self.animeInfoURL) { (result: Result<AnimeInfoDTO, Error>) in
			switch result {
			case .success(let requestData):
				//print("[NETWORK] model is: \(requestData)")
				if let animeInfo = requestData.data {
					self.detailAnimesInstance.append(DetailAnimeModel(malID: animeInfo.malID,
																	  rank: animeInfo.rank,
																	  title: animeInfo.title,
																	  url: animeInfo.url,
																	  imageURL: animeInfo.images["webp"]?.largeImageURL ?? "",
																	  type: animeInfo.type,
																	  source: animeInfo.source,
																	  status: animeInfo.status,
																	  rating: animeInfo.rating,
																	  synopsis: animeInfo.synopsis ?? "No Synopsis",
																	  episodes: animeInfo.episodes ?? 0,
																	  members: animeInfo.members,
																	  favorites: animeInfo.favorites,
																	  score: animeInfo.score))
					self.setData()
				}
				else {
					DispatchQueue.main.async {
					self.router.goToShowAlertMessage(title: "Error",
													 message: "Loading data failed",
													 popViewController: true)
					}
				}
				
				DispatchQueue.main.async {
					self.view?.hideActivityIndicator()
				}
				self.countRequests = 0
			case .failure(let error):
				print("[NETWORK] error is: \(error)")
				self.countRequests += 1
				print("Загрузка закончена с ошибкой \(error.localizedDescription)")
				
				DispatchQueue.main.async {
					self.view?.hideActivityIndicator()
				}
				
				if self.countRequests <= 5 {
					self.loadData()
				}
				else {
					DispatchQueue.main.async {
					self.router.goToShowAlertMessage(title: "Error",
													 message: error.localizedDescription,
													 popViewController: true)
					}
					self.countRequests = 0
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
		
		DispatchQueue.main.async {
			self.controller?.navigationItem.title = "\(data.rank) place"
			self.view?.setData(data)
		}
	}
	
	func setHandlers() {
		self.router.setGoToShowAlertMessageHandler { title, message, popViewController in
			self.controller?.showAlertMessage(title: title,
											  message: message,
											  popViewController: popViewController)
		}
	}
}
