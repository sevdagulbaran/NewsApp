//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsSearchBar: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    
    
    var articles: [Article] = []
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "NewTableViewCell")
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        newsSearchBar.delegate = self
    }

}

// MARK: -Protocols

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell") as? NewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.article = articles[indexPath.row]
        
        return cell
    }
    
    
}

extension NewsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else {
            return
        }
        
        viewController.article = articles[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if articles.count - 1 == indexPath.row {
            page += 1
            fetchData(text: newsSearchBar.text ?? "", page: page)
        }

    }

}

extension NewsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        page = 1
        articles.removeAll()
        newsTableView.reloadData()
        fetchData(text: searchText, page: page)
    }
    
}

// MARK: -Service

extension NewsListViewController {
    
    func fetchData(text: String, page: Int){
                
        NewsService.shared.fetchArticles(text: text, page: page) { response in
            DispatchQueue.main.async {
                if let articles = response.articles {
                    self.articles += articles
                    self.newsTableView.reloadData()
                }
            }
        }
        
    }
    
}
