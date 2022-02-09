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
	private let animeTopURL: String = "https://api.jikan.moe/v4/top/anime?page="
	private var countRequests: Int
	private var isLoadingList: Bool
	private var currentPage: Int
	
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
		self.isLoadingList = true
		self.countRequests = 0
		self.currentPage = 1
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
		
		self.setHandlers()
		self.pullToRefresh()
	}
}

private extension AnimeListPresenter
{
	func pullToRefresh() {
		self.loadData()
		DispatchQueue.main.async {
			self.view?.stopRefreshing()
		}
	}
	
	func loadData() {
		self.isLoadingList = true
		self.network.loadData(urlString: self.animeTopURL + String(self.currentPage)) { (result: Result<AnimeTopDTO, Error>) in
			switch result {
			case .success(let requestData):
				//print("[NETWORK] model is: \(requestData)")
				if let animes = requestData.data {
				for anime in animes {
					self.animesInstance.append(AnimeModel(malID: anime.malID,
														  rank: anime.rank,
														  title: anime.title,
														  url: anime.url,
														  imageURL: anime.images["webp"]?.largeImageURL ?? "",
														  type: anime.type,
														  episodes: anime.episodes ?? 0,
														  members: anime.members,
														  score: anime.score))
					}
					self.currentPage += 1
					self.updateData()
				}
				else {
					DispatchQueue.main.async {
					self.router.goToShowAlertMessage(title: "Error",
													 message: "Loading data failed",
													 popViewController: false)
					}
				}
				self.isLoadingList = false
				self.countRequests = 0
			case .failure(let error):
				print("[NETWORK] error is: \(error)")
				self.countRequests += 1
				print("Загрузка закончена с ошибкой \(error.localizedDescription)")
				if self.countRequests <= 5 {
					self.loadData()
				}
				else {
					self.isLoadingList = false
					DispatchQueue.main.async {
						self.router.goToShowAlertMessage(title: "Error",
														 message: error.localizedDescription,
														 popViewController: false)
					}
					self.countRequests = 0
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
		
		DispatchQueue.main.async {
			self.collectionDataSource.updateSnapshot(with: animes)
		}
	}

	func setHandlers() {
		self.collectionDelegate.setOnTouchedHandler { [weak self] malID in
			print("touched malID -", malID)
			self?.router.goToDetailPage(malID: malID)
		}
		
		self.router.setPushControllerHandler { [weak self] malID in
			self?.controller?.pushDetailPage(malID: malID)
		}
		
		self.view?.setOnRefreshHandler { [weak self] in
			self?.pullToRefresh()
		}
		
		self.router.setGoToShowAlertMessageHandler { title, message, popViewController in
			self.controller?.showAlertMessage(title: title,
											  message: message,
											  popViewController: popViewController)
		}
		
		self.collectionDelegate.setOnScrolledHandler { [weak self] in
			if self?.isLoadingList == false {
				self?.loadData()
			}
		}
	}
}
