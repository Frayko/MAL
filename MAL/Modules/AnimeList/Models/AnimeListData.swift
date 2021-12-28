//
//  AnimeListData.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation
import UIKit

struct AnimeListData
{
	let malID: Int
	let rank: Int
	let title: String
	let type: String
	let episodes: Int
	let members: Int
	let score: Double
	let imageURL: String
}

extension AnimeListData: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(self.malID)
	}
}
