//
//  AnimeListPresenter.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

protocol IAnimeListPresenter
{
	func loadView(controller: IAnimeListVC, view: IAnimeListView)
}

final class AnimeListPresenter
{
	private let model: IAnimeListModel
	private let router: IAnimeListRouter
	private let network: INetworkService
	private let animeStorage: IAnimeDBStorage
	private weak var view: IAnimeListView?
	private weak var controller: IAnimeListVC?
	private let collectionDelegate: IAnimeListCollectionDelegate
	private let collectionDataSource: IAnimeListCollectionDataSource
	private var animesInstance: AnimeStorage
	private let animeTopURL: String = "https://api.jikan.moe/v3/top/anime"
	
	struct Dependecies {
		let model: IAnimeListModel
		let router: IAnimeListRouter
		let network: INetworkService
		let animeStorage: IAnimeDBStorage
	}
	
	init(dependecies: Dependecies) {
		self.model = dependecies.model
		self.router = dependecies.router
		self.network = dependecies.network
		self.animeStorage = dependecies.animeStorage
		self.animesInstance = AnimeStorage.shared
		self.collectionDataSource = AnimeListCollectionDataSource()
		self.collectionDelegate = AnimeListCollectionDeletage()
	}
}

extension AnimeListPresenter: IAnimeListPresenter
{
	func loadView(controller: IAnimeListVC, view: IAnimeListView) {
		self.controller = controller
		self.view = view
		self.view?.setCollectionDelegate(delegate: self.collectionDelegate)
		self.view?.didLoad()
		
		guard let view = self.view else { return }
		
		self.collectionDelegate.setCollectionView(view: view.getAnimesCollectionView())
		self.collectionDataSource.setCollectionView(view: view.getAnimesCollectionView())
		
		self.collectionDataSource.didLoad()
		self.collectionDelegate.setDataSource(self.collectionDataSource.getDataSource())
		
	
		self.loadData()
		self.setHandlers()
	}
}

private extension AnimeListPresenter
{
	func loadData() {
		self.view?.startRefreshing()
		self.network.loadData(urlString: self.animeTopURL) { (result: Result<AnimeTopRequest, Error>) in
			switch result {
			case .success(let animeTopRequest):
				print("[NETWORK] model is: \(animeTopRequest)")
				DispatchQueue.main.async {
					print(animeTopRequest)
					
					for anime in animeTopRequest.top {
						self.animesInstance.append(AnimeModel(malID: anime.malID,
															  rank: anime.rank,
															  title: anime.title,
															  url: anime.url,
															  imageURL: anime.imageURL,
															  type: anime.type.rawValue,
															  episodes: anime.episodes,
															  startDate: anime.startDate ?? "",
															  endDate: anime.endDate ?? "",
															  members: anime.members,
															  score: anime.score))
					}
					
					self.updateData()
					self.view?.stopRefreshing()
				}
			case .failure(let error):
				print("[NETWORK] error is: \(error)")
				DispatchQueue.main.async {
					print("Загрузка закончена с ошибкой \(error.localizedDescription)")
				}
			}
		}
	}
	
	func updateData() {
		var animes = [AnimeListData]()
		
		for rawAnime in self.animesInstance.getAnimes() {
			self.model.setData(data: rawAnime)
			animes.append(self.model.getData())
		}
		
		self.collectionDataSource.updateSnapshot(with: animes)
	}

	func setHandlers() {
		self.collectionDelegate.setOnTouchedHandler { [weak self] malID in
			print("touched malID -", malID)
			self?.router.goToDetailPage(malID: malID)
		}
		
		self.router.setPushControllerHandler { [weak self] malID in
			self?.controller?.pushDetailPage(malID: malID)
		}
		
		self.view?.setOnRefreshHandler {
			self.loadData()
		}
	}
}
