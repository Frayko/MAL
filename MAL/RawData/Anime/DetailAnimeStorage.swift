//
//  DetailDetailAnimeStorage.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

final class DetailAnimeStorage
{
	static let shared = DetailAnimeStorage()
	private var animes: [DetailAnimeModel]
	
	private init() {
		self.animes = [DetailAnimeModel]()
		
		self.animes = [
			TestDetailAnimes.anime1,
			TestDetailAnimes.anime2,
			TestDetailAnimes.anime3,
			TestDetailAnimes.anime4,
			TestDetailAnimes.anime5
		]
	}
}

extension DetailAnimeStorage
{
	func append(_ anime: DetailAnimeModel) {
		self.animes.append(anime)
	}
	
	func getAnimes() -> [DetailAnimeModel] {
		self.animes
	}
	
	func getAnime(malID: Int) -> DetailAnimeModel? {
		self.animes.first { $0.malID == malID }
	}
}
