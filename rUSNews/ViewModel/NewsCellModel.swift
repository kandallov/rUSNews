//
//  NewsCellModel.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol NewsCellModeling {
  var source: String { get }
  var title: String { get }
  var date: String { get }
  var photo: Observable<UIImage> { get }
}

class NewsCellModel: NewsCellModeling {
  let source: String
  let title: String
  let date: String
  let photo: Observable<UIImage>
  
  init(apiworker: APIWorking, source: String, title: String, date: String, urlToImage: String) {
    self.source = source
    self.title = title
    self.date = date
    let placeholder = #imageLiteral(resourceName: "placeholder")
    self.photo = Observable.just(placeholder)
      .concat(apiworker.photoGet(url: urlToImage))
      .observeOn(MainScheduler.instance)
      .catchErrorJustReturn(placeholder)
  }
  
}
