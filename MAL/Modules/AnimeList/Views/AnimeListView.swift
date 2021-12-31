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
	func startRefreshing()
	func stopRefreshing()
	func getAnimesCollectionView() -> UICollectionView
	func setOnRefreshHandler(_ handler: @escaping (() -> Void))
}

final class AnimeListView: UIView {
	private var onRefreshHandler: (() -> Void)?
	
	private lazy var refreshControll: UIRefreshControl = {
		let refresh = UIRefreshControl()
		refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refresh.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
		return refresh
	}()
	
	private lazy var animesCollectionView: UICollectionView = {
		let layout = createAnimeListLayout()
		let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.addSubview(self.refreshControll)
		return collectionView
	}()
}

extension AnimeListView: IAnimeListView {
	func setOnRefreshHandler(_ handler: @escaping (() -> Void)) {
		self.onRefreshHandler = handler
	}
	
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
	
	func stopRefreshing() {
		self.refreshControll.endRefreshing()
		self.refreshControll.attributedTitle = NSAttributedString(string: "Pull to refresh")
	}
	
	func startRefreshing() {
		self.refreshControll.beginRefreshing()
		self.refreshControll.attributedTitle = NSAttributedString(string: "Refreshing")
	}
}

private extension AnimeListView
{
	@objc
	func refreshCollection() {
		self.onRefreshHandler?()
	}
	
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
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(AnimeListLayout.cellFractionalWidth),
												   heightDimension: .estimated(AnimeListLayout.cellHeight))
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

