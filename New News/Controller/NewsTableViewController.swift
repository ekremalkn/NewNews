//
//  ViewController.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//
// NewsApi = a7f433d1e04c48658d8d805467db0878
import UIKit


class NewsTableViewController: UITableViewController {
    
    
    

    var articles = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
        tableView.tableFooterView = UIView()
        self.navigationItem.title = "NewNews"
     
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
        cell.sizeToFit()
        cell.newsTitle.text = articles[indexPath.row].title
        cell.newsSource.text = "Source: \(articles[indexPath.row].source.name)"
        if articles[indexPath.row].author == nil {
            cell.newsAuthor.text = "Author: Anonymous "
        } else {
            cell.newsAuthor.text = "Author: \(articles[indexPath.row].author!)"
        }
       
        
        
        if articles[indexPath.row].urlToImage == nil {
            cell.newsImage.image = UIImage(named: "nosign")
            
        } else {
            if let imageURL = URL(string: articles[indexPath.row].urlToImage) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.newsImage.image = image
                        }
                    }
                }
                
               
            }
        }
        
       
                return cell
    }
    
    
    

    
    
    
   

}


