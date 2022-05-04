//
//  ArticlesResponse.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import Foundation

struct ArticlesResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}
