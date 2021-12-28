//
//  AnimeListView.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

protocol IAnimeListView: UIView {
	func didLoad()
	func setCollectionDelegate(delegate: IAnimeListCollectionDelegate)
	func getAnimesCollectionView() -> UICollectionView
	func reloadView()
}

final class AnimeListView: UIView {
	private lazy var animesCollectionView: UICollectionView = {
		let layout = createAnimeListLayout()
		let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return collectionView
	}()
}

extension AnimeListView: IAnimeListView {
	func setCollectionDelegate(delegate: IAnimeListCollectionDelegate) {
		self.animesCollectionView.delegate = delegate
	}
	
	func getAnimesCollectionView() -> UICollectionView {
		self.animesCollectionView
	}
	
	func didLoad() {
		self.configUI()
		self.configView()
	}
	
	func reloadView() {
		self.animesCollectionView.reloadData()
	}
}

private extension AnimeListView {
	func configUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configView() {
		let vStack = UIStackView(arrangedSubviews: [self.animesCollectionView])
		vStack.axis = .vertical
		vStack.spacing = AnimeListLayout.stackViewSpacing
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(vStack)
		
		let safeArea = self.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
			vStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			vStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			vStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
	
	func createAnimeListLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
			layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
			let contentSize = layoutEnvironment.container.effectiveContentSize

			let columns = Int(round(contentSize.width / AnimeListLayout.cellHeight))
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(AnimeListLayout.itemWidthSize),
												  heightDimension: .fractionalHeight(AnimeListLayout.itemHeightSize))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(AnimeListLayout.cellWidth),
												   heightDimension: .absolute(AnimeListLayout.cellHeight))
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
			group.interItemSpacing = .fixed(AnimeListLayout.collectionViewSpacing)

			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = AnimeListLayout.collectionViewSpacing
			section.contentInsets = NSDirectionalEdgeInsets(top: AnimeListLayout.sectionTopInset,
															leading: AnimeListLayout.sectionLeadingInset,
															bottom: AnimeListLayout.sectionBottomInset,
															trailing: AnimeListLayout.sectionTrailingInset)

			return section
		}
		return layout
	}
}

