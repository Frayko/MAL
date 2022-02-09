//
//  AnimeListDBStorage.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation
import CoreData

final class AnimeListDBStorage {
	private enum Constants {
		static let containerName = "Anime_List"
		static let entityName = "Anime"
	}

	private lazy var container: NSPersistentContainer = {
		let container = NSPersistentContainer(name: Constants.containerName)
		container.loadPersistentStores(completionHandler: { (_, error) in
			guard let error = error as NSError? else { return }
			fatalError("Unresolved error \(error), \(error.userInfo)")
		})
		return container
	}()
}

extension AnimeListDBStorage: IAnimeDBStorage {
	func getAnimes() -> [Anime] {
		let fetchRequest: NSFetchRequest<Anime> = Anime.fetchRequest()
		return (try? self.container.viewContext.fetch(fetchRequest)) ?? [Anime]()
	}

	func create(anime: AnimeModel, completion: @escaping () -> Void) {
		self.container.performBackgroundTask { context in
			defer {
				DispatchQueue.main.async { completion() }
			}
			let object = Anime(context: context)
			object.malID = Int64(anime.malID)
			object.rank = Int64(anime.rank)
			object.title = anime.title
			object.url = anime.url
			object.imageURL = anime.imageURL
			object.type = anime.type
			object.episodes = Int64(anime.episodes)
			object.members = Int64(anime.members)
			object.score = anime.score
			try? context.save()
		}
	}

	func update(anime: AnimeModel, completion: @escaping () -> Void) {
		self.container.performBackgroundTask { context in
			let fetchRequest: NSFetchRequest<Anime> = Anime.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Anime.malID)) = %@", anime.malID)
			if let object = try? context.fetch(fetchRequest).first {
				object.malID = Int64(anime.malID)
				object.rank = Int64(anime.rank)
				object.title = anime.title
				object.url = anime.url
				object.imageURL = anime.imageURL
				object.type = anime.type
				object.episodes = Int64(anime.episodes)
				object.members = Int64(anime.members)
				object.score = anime.score
			}
			try? context.save()
			DispatchQueue.main.async { completion() }
		}
	}

	func remove(anime: AnimeModel, completion: @escaping () -> Void) {
		self.container.performBackgroundTask { context in
			let object = Anime(context: context)
			object.malID = Int64(anime.malID)
			object.rank = Int64(anime.rank)
			object.title = anime.title
			object.url = anime.url
			object.imageURL = anime.imageURL
			object.type = anime.type
			object.episodes = Int64(anime.episodes)
			object.members = Int64(anime.members)
			object.score = anime.score
			context.delete(object)
			try? context.save()
			DispatchQueue.main.async { completion() }
		}
	}
}
