//
//  AnimeListModel.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

protocol IAnimeListModel {
	func setData(data: AnimeModel)
	func setData(data: AnimeListData)
	func getData() -> AnimeListData
}

final class AnimeListModel {
	private var data: AnimeListData?
}

extension AnimeListModel: IAnimeListModel {
	func setData(data: AnimeModel) {
		self.data = AnimeListData(malID: data.malID,
								  rank: data.rank,
								  title: data.title,
								  type: data.type,
								  episodes: data.episodes,
								  members: data.members,
								  score: data.score,
								  image: data.image)
	}
	
	func setData(data: AnimeListData) {
		self.data = data
	}
	
	func getData() -> AnimeListData {
		guard let data = self.data else {
			return AnimeListData(malID: -1,
								 rank: -1,
								 title: "",
								 type: "",
								 episodes: -1,
								 members: -1,
								 score: 0.0,
								 image: UIImage())
		}
		
		return data
	}
}
