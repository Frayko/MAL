//
//  ErrorResponseDTO.swift
//  MAL
//
//  Created by Александр Фомин on 02.01.2022.
//

import Foundation

struct ErrorResponseDTO: Codable {
	let status: Int
	let type, message, error: String
	let reportURL: String

	enum CodingKeys: String, CodingKey {
		case status, type, message, error
		case reportURL = "report_url"
	}
}
