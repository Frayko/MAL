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
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .lightGray
		imageView.layer.borderColor = UIColor.lightGray.cgColor
		imageView.layer.borderWidth = AnimeListLayout.itemBorderWidth
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = AnimeListLayout.animeCellImageCornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var rankLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var title: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var typeAndEpisodesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
		label.adjustsFontForContentSizeCategory = true
		label.textAlignment = .left
		return label
	}()
	
	private lazy var scoreImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "star")
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
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
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
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
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
		hStack.spacing = AnimeListLayout.stackViewSpacing
		hStack.alignment = .leading
		hStack.layer.masksToBounds = true
		hStack.translatesAutoresizingMaskIntoConstraints = false
		
		return hStack
	}()
	
	private lazy var mainStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.rankLabel,
													self.title,
													self.infoStackView])
		
		vStack.axis = .vertical
		vStack.spacing = AnimeListLayout.stackViewSpacing
		vStack.backgroundColor = .systemBackground
		vStack.alignment = .leading
		vStack.layer.opacity = AnimeListLayout.mainStackOpacity
		vStack.layer.masksToBounds = true
		vStack.layer.cornerRadius = AnimeListLayout.animeCellImageCornerRadius
		vStack.layer.borderColor = UIColor.lightGray.cgColor
		vStack.layer.borderWidth = AnimeListLayout.itemBorderWidth
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
		self.imageView.downloaded(from: data.imageURL)
		self.rankLabel.text = "  Rank #\(data.rank)"
		self.title.text = "  \(data.title)"
		self.typeAndEpisodesLabel.text = "  \(data.type)(\(data.episodes))"
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
			self.mainStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
			self.mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			self.mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
			])
	}
}

extension UIImageView {
	func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
		}.resume()
	}
	func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}
