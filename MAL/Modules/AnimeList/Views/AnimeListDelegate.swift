//
//  AnimeListDelegate.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

enum Section: CaseIterable {
	case main
}

protocol IAnimeListCollectionDelegate: UICollectionViewDelegate
{
	func setCollectionView(view: UICollectionView)
	func setOnTouchedHandler(_ handler: @escaping ((Int) -> Void))
	func setDataSource(_ dataSource: UICollectionViewDiffableDataSource<Section, AnimeListData>?)
}

final class AnimeListCollectionDeletage: NSObject
{
	private var onTouchedHandler: ((_ malID: Int) -> Void)?
	private var collectionView: UICollectionView?
	private var dataSource: UICollectionViewDiffableDataSource<Section, AnimeListData>?
}

extension AnimeListCollectionDeletage: IAnimeListCollectionDelegate
{
	func setDataSource(_ dataSource: UICollectionViewDiffableDataSource<Section, AnimeListData>?) {
		self.dataSource = dataSource
	}
	
	func setOnTouchedHandler(_ handler: @escaping ((Int) -> Void)) {
		self.onTouchedHandler = handler
	}
	
	func setCollectionView(view: UICollectionView) {
		self.collectionView = view
	}
}

extension AnimeListCollectionDeletage: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.collectionView?.deselectItem(at: indexPath, animated: true)
		guard let anime = self.dataSource?.itemIdentifier(for: indexPath) else {
			return
		}
		self.onTouchedHandler?(anime.malID)
	}
}
