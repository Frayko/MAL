//
//  AnimeInfoDTO.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

struct AnimeInfoDTO: Codable {
	let data: TemplateAnimeDTO?
	let error: ErrorResponseDTO?
}
