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
	
	func has(malID: Int) -> Bool {
		if let _ = self.animes.first(where: { $0.malID == malID } ) {
			return true
		} else {
			return false
		}
	}
}
