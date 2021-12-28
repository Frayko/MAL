//
//  TestAnimes.swift
//  MAL
//
//  Created by Александр Фомин on 26.12.2021.
//

import UIKit

enum TestAnimes
{
	static let anime1 = AnimeModel(malID: 5114,
								   rank: 1,
								   title: "Fullmetal Alchemist: Brotherhood",
								   url: URL(string: "testURL"),
								   image: UIImage().withTintColor(.magenta),
								   type: "TV",
								   episodes: 64,
								   startDate: "Apr 2009",
								   endData: "Jul 2010",
								   members: 2716506,
								   score: 9.15)
	
	static let anime2 = AnimeModel(malID: 5113,
								   rank: 1,
								   title: "Fullmetal Alchemist: Brotherhood",
								   url: URL(string: "testURL"),
								   image: UIImage().withTintColor(.magenta),
								   type: "TV",
								   episodes: 64,
								   startDate: "Apr 2009",
								   endData: "Jul 2010",
								   members: 2716506,
								   score: 9.15)
	
	static let anime3 = AnimeModel(malID: 5112,
								   rank: 1,
								   title: "Fullmetal Alchemist: Brotherhood",
								   url: URL(string: "testURL"),
								   image: UIImage().withTintColor(.magenta),
								   type: "TV",
								   episodes: 64,
								   startDate: "Apr 2009",
								   endData: "Jul 2010",
								   members: 2716506,
								   score: 9.15)
	
	static let anime4 = AnimeModel(malID: 5111,
								   rank: 1,
								   title: "Fullmetal Alchemist: Brotherhood",
								   url: URL(string: "testURL"),
								   image: UIImage(),
								   type: "TV",
								   episodes: 64,
								   startDate: "Apr 2009",
								   endData: "Jul 2010",
								   members: 2716506,
								   score: 9.15)
	
	static let anime5 = AnimeModel(malID: 5110,
								   rank: 1,
								   title: "Fullmetal Alchemist: Brotherhood",
								   url: URL(string: "testURL"),
								   image: UIImage(),
								   type: "TV",
								   episodes: 64,
								   startDate: "Apr 2009",
								   endData: "Jul 2010",
								   members: 2716506,
								   score: 9.15)
}
