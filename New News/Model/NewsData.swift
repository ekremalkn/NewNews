//
//  NewsData.swift
//  New News
//
//  Created by Ekrem Alkan on 7.10.2022.
//

import Foundation

struct NewsData: Codable{
    let articles: [Articles]
    
    
    
}

struct Articles: Codable {
    let author : String?
    let title : String?
    let description: String?
    let source: Source
    
    
}

struct Source: Codable {
    let name: String?
}


