//
//  APIWorker.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol APIWorking {
  func getNews(selectionIndex: Int) -> Observable<News>
  func buildRequest(countryIndex: String) -> Observable<Data>
}

final class APIWorker: APIWorking {
  
  private let apiKey = "acdf109f02b54e84b7345254f4c910c7"
  
  func getNews(selectionIndex: Int) -> Observable<News> {
    let countryIndex = getCountryId(selectedIndex: selectionIndex)
    return buildRequest(countryIndex: countryIndex)
      .map { data in
        do {
          let news = try JSONDecoder().decode(News.self, from: data)
          return news
        } catch let error {
          print("JSON error: \(error)")
          return News.empty
        }
    }
  }
  
  func buildRequest(countryIndex: String) -> Observable<Data> {
    let url = URL(string: "https://newsapi.org/v2/top-headlines")!
    var request = URLRequest(url: url)
    
    let keyQueryItem = URLQueryItem(name: "apiKey", value: apiKey)
    let categoryQuertyItem = URLQueryItem(name: "category", value: "business")
    let countryQueryItem = URLQueryItem(name: "country", value: countryIndex)
    
    let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = [countryQueryItem, categoryQuertyItem, keyQueryItem]
    request.url = urlComponents.url!
    request.httpMethod = "GET"
    
    return URLSession.shared.rx.data(request: request).map { $0 }
  }
  
  private func getCountryId(selectedIndex: Int) -> String {
    switch selectedIndex {
    case 0:
      return "us"
    case 1:
      return "ru"
    default:
      print("Oops... something went wrong with get country id")
      return ""
    }
  }

}
