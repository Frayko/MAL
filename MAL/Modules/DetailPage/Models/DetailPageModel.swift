//
//  DetailPageModel.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import UIKit

protocol IDetailPageModel {
	func setData(data: DetailAnimeModel)
	func getData() -> DetailAnimeModel
}

final class DetailPageModel {
	private var data: DetailAnimeModel?
}

extension DetailPageModel: IDetailPageModel {
	func setData(data: DetailAnimeModel) {
		self.data = data
	}
	
	func getData() -> DetailAnimeModel {
		guard let data = self.data else {
			return DetailAnimeModel(malID: -1,
									rank: -1,
									title: "",
									url: nil,
									image: UIImage(),
									type: "",
									source: "",
									status: "",
									rating: "",
									synopsis: "",
									episodes: -1,
									members: -1,
									favorites: -1,
									score: 0.0)
		}
		
		return data
	}
}
