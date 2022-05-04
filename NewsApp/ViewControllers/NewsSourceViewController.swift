//
//  NewsSourceViewController.swift
//  NewsApp
//
//  Created by Sevda Gul Baran on 30.04.2022.
//

import UIKit
import WebKit

class NewsSourceViewController: UIViewController {

@IBOutlet weak var newWebView: WKWebView!
    
    var webUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News Source"
        
        let url = URL(string: webUrl ?? "")
        if let url = url {
            let request = URLRequest(url: url)
            newWebView.load(request)
        }
  
    }
    
}

