//
//  NewDetaillViewController.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import UIKit
import Kingfisher


class NewsDetailViewController: UIViewController {


    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var newAuthorLabel: UILabel!
    @IBOutlet weak var newDateLabel: UILabel!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: article?.urlToImage ?? "")
        newImageView.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        newTitleLabel.text = article?.title
        if let author = article?.author {
            newAuthorLabel.text = author
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        if let publishedAt = article?.publishedAt {
            let date = dateFormatterGet.date(from: publishedAt)
            if let date = date {
                newDateLabel.text = dateFormatterPrint.string(from: date)
            }
        }
        
        newDescriptionLabel.text = article?.content
        
        if isFavoriteExist(title: article?.title ?? "") {
            favoriteBarButtonItem.image = UIImage(systemName: "heart.fill")
        }else {
            favoriteBarButtonItem.image = UIImage(systemName: "heart")
        }
    }

    @IBAction func newSourceButtonTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "NewsSourceViewController") as? NewsSourceViewController else {
            return
        }
        
        viewController.webUrl = article?.url
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let url = article?.url else { return }
        let viewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(viewController, animated: true)
        
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        
        guard let article = article else {
            return
        }
        
        if isFavoriteExist(title: article.title ?? "") {
            removeFromFavorites(article: article)
            favoriteBarButtonItem.image = UIImage(systemName: "heart")
        }else {
            addToFavorites(article: article)
            favoriteBarButtonItem.image = UIImage(systemName: "heart.fill")
        }
                
    }
    
    func getFavorites() -> [Article] {
        
        guard let favorites = UserDefaults.standard.array(forKey: "favorites") else {
            return []
        }
        
        var myFavorites: [Article] = []
        
        favorites.forEach { favorite in
            
            if let favoriteData = favorite as? Data {
                
                do {
                    let favorite = try JSONDecoder().decode(Article.self, from: favoriteData)
                    myFavorites.append(favorite)
                } catch  {
                    print(error.localizedDescription)
                }
                
            }
            
        }
        
        return myFavorites
    }
    
    func isFavoriteExist(title: String) -> Bool {
        
        let favorites = getFavorites()
        return (favorites.filter {$0.title == title}.count > 0)

    }
    
    func addToFavorites(article: Article) {
        
        guard var favorites = UserDefaults.standard.array(forKey: "favorites") else {
            return
        }
        
        do {
            let encodedFavorite = try JSONEncoder().encode(article)
            favorites.append(encodedFavorite)
        } catch {
            print(error.localizedDescription)
        }

        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
    
    func removeFromFavorites(article: Article){
        
        var encodedFavorites: [Data] = []
        
        let favorites = getFavorites().filter{ $0.title != article.title }
        
        favorites.forEach { favorite in
            do {
                let encodedFavorite = try JSONEncoder().encode(favorite)
                encodedFavorites.append(encodedFavorite)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        UserDefaults.standard.set(encodedFavorites, forKey: "favorites")
        
    }
    
}

