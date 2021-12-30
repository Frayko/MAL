//
//  DetailPageView.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import UIKit

protocol IDetailPageView: UIView {
	func didLoad()
	func setData(_ data: DetailAnimeModel)
}

final class DetailPageView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.center = self.center
		imageView.backgroundColor = .lightGray
		imageView.widthAnchor.constraint(equalToConstant: DetailPageLayout.imageViewWidthConstant).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: DetailPageLayout.imageViewHeightConstant).isActive = true
		
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var scoreImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "star")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.widthAnchor.constraint(equalToConstant: DetailPageLayout.iconImageViewWidth).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: DetailPageLayout.iconImageViewHeight).isActive = true
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var scoreLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var typeAndEpisodesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
//
//	private lazy var countEpisodesLabel: UILabel = {
//		let label = UILabel()
//		label.numberOfLines = 0
//		label.contentMode = .scaleAspectFit
//		label.textAlignment = .left
//		label.font = UIFont.preferredFont(forTextStyle: .body)
//		label.translatesAutoresizingMaskIntoConstraints = false
//		return label
//	}()
	
	private lazy var airStatusLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var sourceImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "book.closed")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.widthAnchor.constraint(equalToConstant: DetailPageLayout.iconImageViewWidth).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: DetailPageLayout.iconImageViewHeight).isActive = true
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var sourceLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var ratingLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .scaleAspectFit
		label.textAlignment = .left
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var descriptionTextView: UITextView = {
		let textView = UITextView(frame: .zero, textContainer: nil)
		textView.backgroundColor = .quaternarySystemFill
		textView.font = .systemFont(ofSize: 20, weight: .light)
		textView.layer.cornerRadius = DetailPageLayout.stackViewCornerRadius
		textView.layer.masksToBounds = true
		textView.textAlignment = .left
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
	
	private lazy var scoreStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.scoreImageView,
													self.scoreLabel])
		
		vStack.axis = .horizontal
		vStack.spacing = DetailPageLayout.stackViewSpacing
		vStack.alignment = .leading
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
	}()
	
	private lazy var sourceStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.sourceImageView,
													self.sourceLabel])
		
		vStack.axis = .horizontal
		vStack.spacing = DetailPageLayout.stackViewSpacing
		vStack.alignment = .leading
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
	}()
	
	private lazy var infoStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.scoreStackView,
													self.ratingLabel,
													self.sourceStackView,
													self.typeAndEpisodesLabel,
													self.airStatusLabel])
		
		vStack.axis = .vertical
		vStack.spacing = DetailPageLayout.stackViewSpacing
		vStack.alignment = .leading
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
	}()
	
	private lazy var mainStackView: UIStackView = {
		let hStack = UIStackView(arrangedSubviews: [self.imageView,
													self.infoStackView])
		
		hStack.axis = .horizontal
		hStack.spacing = DetailPageLayout.stackViewSpacing
		hStack.backgroundColor = .quaternaryLabel
		hStack.alignment = .center
		hStack.layer.cornerRadius = DetailPageLayout.stackViewCornerRadius
		hStack.layer.masksToBounds = true
		hStack.translatesAutoresizingMaskIntoConstraints = false
		
		return hStack
	}()
	
	private lazy var fullStackView: UIStackView = {
		let vStack = UIStackView(arrangedSubviews: [self.titleLabel,
													self.mainStackView,
													self.descriptionTextView])
		
		vStack.axis = .vertical
		vStack.spacing = DetailPageLayout.stackViewSpacing
		vStack.backgroundColor = .systemBackground
		vStack.alignment = .center
		vStack.layer.cornerRadius = DetailPageLayout.stackViewCornerRadius
		vStack.layer.masksToBounds = true
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		return vStack
	}()
}

extension DetailPageView: IDetailPageView {
	func didLoad() {
		self.configureUI()
		self.configureView()
		self.configureScrollView()
	}
	
	func setData(_ data: DetailAnimeModel) {
		self.imageView.downloaded(from: data.imageURL)
		self.titleLabel.text = data.title
		self.scoreLabel.text = "\(data.score)"
		self.ratingLabel.text = "Rating: \(data.rating)"
		self.sourceLabel.text = "\(data.source)"
		self.typeAndEpisodesLabel.text = "\(data.type) (\(data.episodes) ep.)"
		self.airStatusLabel.text = "\(data.status)"
		self.descriptionTextView.text = "\(data.synopsis)"
	}
}

private extension DetailPageView {
	func configureUI() {
		self.backgroundColor = .systemBackground
	}
	
	func configureView() {
		let scrollArea = self.scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.fullStackView)
	
		NSLayoutConstraint.activate([
			self.fullStackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												constant: DetailPageLayout.stackViewTopAnchor),
			self.fullStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
													constant: DetailPageLayout.stackViewLeadingAnchor),
			self.fullStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
													 constant: DetailPageLayout.stackViewTrailingAnchor),
			self.fullStackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
												   constant: DetailPageLayout.stackViewBottomAnchor)
		])
	}
	
	func configureScrollView() {
		let safeArea = self.safeAreaLayoutGuide
		self.addSubview(self.scrollView)

		NSLayoutConstraint.activate([
			self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
			self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
			self.scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
			self.scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
			self.scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor)
		])
	}
}
