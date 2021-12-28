//
//  AnimeListViewCell.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

final class AnimeCell: UICollectionViewCell {
	static let reuseIdentifier = "anime-cell-reuse-identifier"
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = AnimeListLayout.animeCellImageCornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var title: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .center
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureView()
	}
	required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
}

extension AnimeCell {
	func setData(data: AnimeListData) {
		self.title.text = data.title
	}
}

private extension AnimeCell {
	func configureView() {
		self.contentView.addSubview(self.imageView)
		
		NSLayoutConstraint.activate([
			self.imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			self.imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor,
												   constant: AnimeListLayout.animeCellImageHeigth),
			self.imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor,
												  constant: AnimeListLayout.animeCellImageWidth),
			self.imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
		
		self.contentView.addSubview(self.title)
		
		NSLayoutConstraint.activate([
			self.title.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
											constant: AnimeListLayout.animeCellBottomAnchor),
			self.title.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor,
												constant: AnimeListLayout.animeCellLeadingAnchor),
			self.title.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor,
												 constant: AnimeListLayout.animeCellTrailingAnchor)
			])
	}
}

