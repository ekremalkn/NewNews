//
//  ViewController.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//
// NewsApi = a7f433d1e04c48658d8d805467db0878
import UIKit

class NewsTableViewController: UITableViewController {
    
    var newsManager = NewsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.fetchNews()
    }

    func getNews(_ newsManager: NewsManager, news: NewsModel){
       
    }

}

