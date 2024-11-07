//
//  SearchModel.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import UIKit

struct SearchResults: Codable {
    let results: [Movie]?
    let totalResults: String?
    let response: String?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

struct Movie: Codable {
    let title: String?
    let year: String?
    let id: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
