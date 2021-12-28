//
//  AnimeListCollectionDataSource.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

protocol IAnimeListCollectionDataSource
{
	func setCollectionView(view: UICollectionView)
	func updateSnapshot(with animes: [AnimeListData])
	func didLoad()
	func getDataSource() -> UICollectionViewDiffableDataSource<Section, AnimeListData>?
}

final class AnimeListCollectionDataSource
{
	private var dataSource: UICollectionViewDiffableDataSource<Section, AnimeListData>?
	private var collectionView: UICollectionView?
}

extension AnimeListCollectionDataSource: IAnimeListCollectionDataSource
{
	func getDataSource() -> UICollectionViewDiffableDataSource<Section, AnimeListData>? {
		return dataSource
	}
	
	func setCollectionView(view: UICollectionView) {
		self.collectionView = view
	}
	
	func updateSnapshot(with animes: [AnimeListData]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, AnimeListData>()
		snapshot.appendSections([.main])
		snapshot.appendItems(animes)
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
	func didLoad() {
		configureDataSource()
	}
}

private extension AnimeListCollectionDataSource
{
	func configureDataSource() {
		let cellRegistration = UICollectionView.CellRegistration
		<AnimeCell, AnimeListData> { (cell, indexPath, anime) in
			cell.setData(data: anime)
		}
		
		guard let collectionView = self.collectionView else { return }
		
		dataSource = UICollectionViewDiffableDataSource<Section, AnimeListData>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: AnimeListData) -> UICollectionViewCell? in
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
}
