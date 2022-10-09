//
//  ViewController.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//
// NewsApi = a7f433d1e04c48658d8d805467db0878
import UIKit
import Kingfisher



class NewsTableViewController: UITableViewController {
    
    var articles = [Article]()

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .systemIndigo
        self.navigationItem.title = "NewNews"
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh.")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)

     
    }
    //MARK: - Pull to refresh

    @objc func refresh(sender:AnyObject)
    {
        

        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
   
    
    
    //MARK: - Networking - JSON Decode

        let newsURL = "https://newsapi.org/v2/everything?q=Apple&from=2022-10-07&sortBy=popularity&apiKey=a7f433d1e04c48658d8d805467db0878"
    
        func fetchNews(){
            performRequest(urlString: newsURL)
            
        }
  
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
           
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else {return}
                
                
              
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Articles.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.articles = decodedData.articles
                        self.tableView.reloadData()
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            }
            task.resume()
          
    }
        
        }
    
    //MARK: - TableViewMethods
    
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
        
        cell.newsTitle.text = articles[indexPath.row].title
        if let sourceName = articles[indexPath.row].source?.name {
            cell.newsSource.text = "Source: \(sourceName)"
        }
        
        if articles[indexPath.row].author == nil {
            cell.newsAuthor.text = "Author: Anonymous "
        } else {
            cell.newsAuthor.text = "Author: \(articles[indexPath.row].author!)"
        }
       
        if let imageURL = URL(string: articles[indexPath.row].urlToImage!) {
        
                DispatchQueue.main.async {
                    let processor = RoundCornerImageProcessor(cornerRadius: 75)
                    
                     
                    cell.newsImage.kf.indicatorType = .activity
                    cell.newsImage.kf.setImage(with: imageURL, options: [.processor(processor)])
                    
                    }
             
            }
        
                return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlString = articles[indexPath.row].url!
        
        if let url = URL(string: urlString){
            UIApplication.shared.open(url)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
     let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 100, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.2
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        
}
   
    
    
 
}
