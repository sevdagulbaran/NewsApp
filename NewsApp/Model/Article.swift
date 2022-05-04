//
//  Article.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import Foundation

struct Article: Codable {
    var source: ArticleSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
