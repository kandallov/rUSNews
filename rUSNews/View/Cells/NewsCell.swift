//
//  NewsCell.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class NewsCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var sourceLabel: UILabel!
  
  private var disposeBag: DisposeBag? = DisposeBag()
  
  var viewModel: NewsCellModeling? {
    didSet {
      let disposeBag = DisposeBag()
      
      guard let viewModel = viewModel else { return }
      
      sourceLabel.text = viewModel.source
      titleLabel.text = viewModel.title
      dateLabel.text = viewModel.date
      
      viewModel.photo
        .bind(to: newsImage.rx.image)
        .disposed(by: disposeBag)
      
      self.disposeBag = disposeBag
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    viewModel = nil
    disposeBag = nil
  }
  
}
