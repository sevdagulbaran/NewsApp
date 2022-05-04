//
//  NewsService.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import Foundation
import Alamofire

class NewsService {
    
    static let shared: NewsService = NewsService()

    private init(){
        
    }
    
    func fetchArticles(text: String, page: Int, completionHandler: @escaping(ArticlesResponse) -> Void) {
        
        let url = ServiceConstants.APIUrl+"v2/everything?q=\(text)&page=\(page)&apiKey="+ServiceConstants.APIKey
        
        AF.request(url).response { response in
            guard let data = response.data else {
                print("Data could not fetched!")
                return
            }
            
            do {
                let articleResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                completionHandler(articleResponse)
            } catch {
                print(error.localizedDescription)
            }
                                    
        }
    }
    
}
