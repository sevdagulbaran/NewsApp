//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.array(forKey: "favorites") == nil{
            UserDefaults.standard.set([], forKey: "favorites")
        }
    }
}
