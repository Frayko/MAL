//
//  NetworkService.swift
//  MAL
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation
import SystemConfiguration

protocol INetworkService
{
	func loadData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
	func checkConnection() -> Bool
}

final class NetworkService: NSObject
{
	private let session: URLSession

	init(configuration: URLSessionConfiguration? = nil) {
		if let configuration = configuration {
			self.session = URLSession(configuration: configuration)
		}
		else {
			self.session = URLSession(configuration: URLSessionConfiguration.default)
		}
	}
}

extension NetworkService: INetworkService
{
	//MARK: Проверять интернет этим методом только если отсутствует какая-либо анимация
	func checkConnection() -> Bool {
		var status = false
		let url = URL(string: "https://google.com/")
		var request = URLRequest(url: url!)
		request.httpMethod = "HEAD"
		request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		request.timeoutInterval = 5.0
		
		let semaphore = DispatchSemaphore(value: 0)
		
		URLSession.shared.dataTask(with: request) { _, response, _ in
			if let httpResponse = response as? HTTPURLResponse {
				if httpResponse.statusCode == 200 {
					status = true
					semaphore.signal()
				}
			}
		}.resume()
		
		_ = semaphore.wait(timeout: .now() + 5.0)

		return status
	}
	
	func loadData<T: Decodable>(urlString: String,completion: @escaping (Result<T, Error>) -> Void) {
		guard let url = URL(string: urlString) else {
			print("Ошибка в ссылке")
			return
		}

		let request = URLRequest(url: url)
		self.session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}
			if let data = data {
				do {
					let result = try JSONDecoder().decode(T.self, from: data)
					//print("[NETWORK] \(response)")
					completion(.success(result))
				}
				catch {
					completion(.failure(error))
				}
			}
		}.resume()
	}
}
