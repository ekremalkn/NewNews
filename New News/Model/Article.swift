//
//  NewsData.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//

import Foundation

class Articles: Codable {
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}
class Article: Codable{
    let author: String?
    let title: String?
    let description: String?
    let source: Source?
    let url: String?
    let urlToImage: String?
    
    
    init(author: String, title: String, description: String, source: Source, url: String, urlToImage: String){
        self.author = author
        self.title = title
        self.description = description
        self.source = source
        self.url = url
        self.urlToImage = urlToImage
    }
    
}



struct Source: Codable {
    let name: String
}


