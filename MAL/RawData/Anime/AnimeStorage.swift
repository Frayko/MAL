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
	private let container = AnimeListDBStorage()
	
	private init() {
		self.animes = [AnimeModel]()
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
	
	func has(malID: Int) -> Bool {
		if let _ = self.animes.first(where: { $0.malID == malID } ) {
			return true
		} else {
			return false
		}
	}
}
