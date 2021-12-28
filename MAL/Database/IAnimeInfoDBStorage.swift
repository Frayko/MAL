//
//  IAnimeInfoDBStorage.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

protocol IAnimeInfoDBStorage {
	func getAnime(malID: Int) -> Anime
	func create(anime: DetailAnimeModel, completion: @escaping () -> Void)
	func update(anime: DetailAnimeModel, completion: @escaping () -> Void)
	func remove(anime: DetailAnimeModel, completion: @escaping () -> Void)
}
