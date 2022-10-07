//
//  NewsManager.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//

import Foundation

protocol NewsManagerDelegate {
    func getNews(_ newsManager: NewsManager, news: NewsModel)
}

struct NewsManager {
    let newsURL = "https://newsapi.org/v2/everything?q=Apple&from=2022-10-07&sortBy=popularity&apiKey=a7f433d1e04c48658d8d805467db0878"
    
    var delegate: NewsManagerDelegate?

    func fetchNews(){
        performRequest(urlString: newsURL)
        
    }
    
  

//MARK: - Networking

    func performRequest(urlString: String){
    if let url = URL(string: urlString){
       
        
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil{
               
                print(error!)
                return
            }
            
        
            DispatchQueue.main.async {
                if let safeData = data {
                    
                    if let news = parseJSON(newsData: safeData){
                        let VC = NewsTableViewController()
                        VC.getNews(self, news: news)
                    }
                    }
            }
        
        }
        task.resume()
        
    }
    
    
}

//MARK: - JSON

func parseJSON(newsData: Data) -> NewsModel?{
    
    let decoder = JSONDecoder()
 
    do {
       
        let decodedData = try decoder.decode(NewsData.self, from: newsData)
   
        let title = decodedData.articles[0].title
        let author = decodedData.articles[0].author
        let description = decodedData.articles[0].description
        let source = decodedData.articles[0].source.name
        
        let news = NewsModel(newsChannel: source, newsAuthor: author, newsTitle: title, newsDescription: description)
        print(news)
        return news
        
    } catch {      
        print(error)
        return nil
            }
   

}
    
    
    
    
}


