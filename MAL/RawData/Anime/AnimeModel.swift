//
//  AnimeModel.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

struct AnimeModel
{
	let malID: Int
	let rank: Int
	let title: String
	let url: String
	let imageURL: String
	let type: String
	let episodes: Int
	let members: Int
	let score: Double
//
//	init(malID: Int,
//		 rank:Int,
//		 title: String,
//		 url: String,
//		 imageURL: String,
//		 type: String,
//		 episodes: Int,
//		 members: Int,
//		 score: Double) {
//		self.malID = malID
//		self.rank = rank
//		self.title = title
//		self.url = url
//		self.imageURL = imageURL
//		self.type = type
//		self.episodes = episodes
//		self.members = members
//		self.score = score
//	}
//
//	init(anime: Anime) {
//		self.malID = Int(anime.malID)
//		self.rank = Int(anime.rank)
//		self.title = anime.title ?? ""
//		self.url = anime.url ?? ""
//		self.imageURL = anime.imageURL ?? ""
//		self.type = anime.type ?? ""
//		self.episodes = Int(anime.episodes)
//		self.members = Int(anime.members)
//		self.score = anime.score
//	}
}
