//
//  SearchRequestModel.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import UIKit

public struct SearchRequest: Codable {
    let apikey: String
    let s: String
}
