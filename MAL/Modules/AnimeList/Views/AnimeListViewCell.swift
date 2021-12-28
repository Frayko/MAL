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
		imageView.backgroundColor = .lightGray
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = AnimeListLayout.animeCellImageCornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var title: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var typeAndEpisodesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 11, weight: .light)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var scoreImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "seal")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.widthAnchor.constraint(equalToConstant: AnimeListLayout.iconImageViewWidth).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: AnimeListLayout.iconImageViewHeight).isActive = true
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var scoreLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 11, weight: .light)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var membersImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "person")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.widthAnchor.constraint(equalToConstant: AnimeListLayout.iconImageViewWidth).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: AnimeListLayout.iconImageViewHeight).isActive = true
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var membersLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 11, weight: .light)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var infoStackView: UIStackView = {
		let hStack = UIStackView(arrangedSubviews: [self.typeAndEpisodesLabel,
													self.scoreImageView,
													self.scoreLabel,
													self.membersImageView,
													self.membersLabel])
		
		hStack.axis = .horizontal
		hStack.spacing = DetailPageLayout.stackViewSpacing
		hStack.alignment = .leading
		//hStack.layer.cornerRadius = DetailPageLayout.stackViewCornerRadius
		hStack.layer.masksToBounds = true
		hStack.translatesAutoresizingMaskIntoConstraints = false
		
		return hStack
	}()
	
	private lazy var mainStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.title,
													self.infoStackView])
		
		vStack.axis = .vertical
		vStack.spacing = DetailPageLayout.stackViewSpacing
		vStack.alignment = .leading
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
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
		self.typeAndEpisodesLabel.text = "\(data.type)(\(data.episodes))"
		self.scoreLabel.text = "\(data.score)"
		self.membersLabel.text = "\(data.members)"
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
		
		self.contentView.addSubview(self.mainStackView)
		
		NSLayoutConstraint.activate([
			self.mainStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,
											constant: -AnimeListLayout.animeCellBottomAnchor),
			self.mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
												constant: AnimeListLayout.animeCellLeadingAnchor),
			self.mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
												 constant: AnimeListLayout.animeCellTrailingAnchor)
			])
	}
}

