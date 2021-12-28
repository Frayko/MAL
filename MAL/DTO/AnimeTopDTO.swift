//
//  AnimeTopDTO.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

struct AnimeTopRequest: Codable {
	let requestHash: String
	let requestCached: Bool
	let requestCacheExpiry: Int
	let top: [AnimeTopDTO]

	enum CodingKeys: String, CodingKey {
		case requestHash = "request_hash"
		case requestCached = "request_cached"
		case requestCacheExpiry = "request_cache_expiry"
		case top
	}
}

struct AnimeTopDTO: Codable {
	let malID: Int
	let rank: Int
	let title: String
	let url: String
	let imageURL: String
	let type: TypeEnum
	let episodes: Int
	let startDate: String?
	let endDate: String?
	let members: Int
	let score: Double

	enum CodingKeys: String, CodingKey {
		case malID = "mal_id"
		case rank, title, url
		case imageURL = "image_url"
		case type, episodes
		case startDate = "start_date"
		case endDate = "end_date"
		case members, score
	}
}

enum TypeEnum: String, Codable {
	case movie = "Movie"
	case ona = "ONA"
	case ova = "OVA"
	case tv = "TV"
}
