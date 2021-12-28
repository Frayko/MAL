//
//  AnimeStorage.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation

final class AnimeStorage
{
	static let shared = AnimeStorage()
	private var animes: [AnimeModel]
	
	private init() {
		self.animes = [AnimeModel]()
		
		self.animes = [
			TestAnimes.anime1,
			TestAnimes.anime2,
			TestAnimes.anime3,
			TestAnimes.anime4,
			TestAnimes.anime5
		]
	}
}

extension AnimeStorage
{
	func append(_ anime: AnimeModel) {
		self.animes.append(anime)
	}
	
	func getAnimes() -> [AnimeModel] {
		self.animes
	}
	
	func getAnime(malID: Int) -> AnimeModel? {
		self.animes.first { $0.malID == malID }
	}
}
