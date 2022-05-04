//
//  FavoriteListViewController.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favorites: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "NewTableViewCell", bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: "NewTableViewCell")
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        favorites.removeAll()
        favoritesTableView.reloadData()
    }
}

// MARK: -Protocols

extension FavoriteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell") as? NewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.article = favorites[indexPath.row]
        
        return cell
    }
    
    
}

extension FavoriteListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else {
            return
        }
        
        viewController.article = favorites[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: -Service

extension FavoriteListViewController {
    
    func fetchData(){
                
        guard let favorites = UserDefaults.standard.array(forKey: "favorites") else {
            return
        }
        
        favorites.forEach { favorite in
            
            guard let favorite = favorite as? Data else {
                return
            }
            
            do {
                let favorite = try JSONDecoder().decode(Article.self, from: favorite)
                self.favorites.append(favorite)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        favoritesTableView.reloadData()
    }
    
}
