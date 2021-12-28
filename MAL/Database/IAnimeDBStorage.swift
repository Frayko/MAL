//
//  IAnimeDBStorage.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

protocol IAnimeDBStorage {
	func getAnimes() -> [Anime]
	func create(anime: AnimeModel, completion: @escaping () -> Void)
	func update(anime: AnimeModel, completion: @escaping () -> Void)
	func remove(anime: AnimeModel, completion: @escaping () -> Void)
}
