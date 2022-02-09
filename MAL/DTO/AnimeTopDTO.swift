//
//  AnimeTopDTO.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

struct AnimeTopDTO: Codable {
	let data: [TemplateAnimeDTO]?
	let pagination: Pagination?
}

struct Pagination: Codable {
	let lastVisiblePage: Int
	let hasNextPage: Bool

	enum CodingKeys: String, CodingKey {
		case lastVisiblePage = "last_visible_page"
		case hasNextPage = "has_next_page"
	}
}
