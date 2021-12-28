//
//  AnimeInfoDTO.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

struct AnimeInfoDTO: Codable {
	let malID: Int
	let url: String
	let imageURL: String
	let title: String
	let type, source: String
	let episodes: Int
	let status: String
	let aired: Aired
	let rating: String
	let score: Double
	let rank, members: Int
	let favorites: Int
	let synopsis: String

	enum CodingKeys: String, CodingKey {
		case malID = "mal_id"
		case url
		case imageURL = "image_url"
		case title
		case type, source, episodes, status, aired, rating, score
		case rank, members, favorites, synopsis
	}
}

struct Aired: Codable {
	let string: String
}
