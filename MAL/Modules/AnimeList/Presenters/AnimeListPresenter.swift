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
	private weak var view: IAnimeListView?
	private weak var controller: IAnimeListVC?
	private let collectionDelegate: IAnimeListCollectionDelegate
	private let collectionDataSource: IAnimeListCollectionDataSource
	private var animesInstance: AnimeStorage
	
	struct Dependecies {
		let model: IAnimeListModel
		let router: IAnimeListRouter
	}
	
	init(dependecies: Dependecies) {
		self.model = dependecies.model
		self.router = dependecies.router
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
		
		self.setData()
		self.setHandlers()
	}
}

private extension AnimeListPresenter
{
	func setData() {
		var animes = [AnimeListData]()
		
		for rawAnime in self.animesInstance.getAnimes() {
			self.model.setData(data: rawAnime)
			animes.append(self.model.getData())
		}
		
		self.collectionDataSource.updateSnapshot(with: animes)
		self.view?.reloadView()
	}

	func setHandlers() {
		self.collectionDelegate.setOnTouchedHandler { [weak self] malID in
			print("touched malID - ", malID)
		}
		
		self.router.setPushControllerHandler { [weak self] id in
			print("test")
			//self?.controller?.pushDetailCar(id: id)
		}
	}
}
