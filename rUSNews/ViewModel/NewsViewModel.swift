//
//  NewsViewModel.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift
import RxCocoa

protocol NewsViewModeling {
  //MARK: - Input
  var countrySigment: PublishSubject<Int> { get }
  //MARK: - Output
  var cellModels: Driver<[NewsCellModeling]> { get }
}

class NewsViewModel: NewsViewModeling {
  //MARK: - Input
  var countrySigment: PublishSubject<Int> = PublishSubject<Int>()
  //MARK: - Output
  var cellModels: Driver<[NewsCellModeling]>
  
  init(apiworker: APIWorking) {
    
    let country = countrySigment
      .flatMapLatest { selectionIndex in
        return apiworker.getNews(selectionIndex: selectionIndex)
      }
      .asDriver(onErrorJustReturn: News.empty)
    
    cellModels = country.asSharedSequence()
      .map { news in
        news.articles.map { new in
          NewsCellModel(apiworker: apiworker, source: new.source.name, title: new.title, date: new.publishedAt, urlToImage: new.urlToImage ?? "https://www.someplace.net")
        }
    }
  }
  
}
