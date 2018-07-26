//
//  News.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

struct News: Codable {
  var status: String
  var totalResults: Int
  var articles: [Articles]
  
  static let empty = News(status: "", totalResults: 0, articles: [Articles(source: Source(name: ""), title: "", urlToImage: "https://www.someplace.net", publishedAt: "")])
}

struct Articles: Codable {
  var source: Source
  var title: String
  var urlToImage: String?
  var publishedAt: String
}

struct Source: Codable {
  var name: String
}
