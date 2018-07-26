//
//  ViewController.swift
//  rUSNews
//
//  Created by Alexander Kandalov on 26.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentCountry: UISegmentedControl!
  
  var viewModel: NewsViewModeling!
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150
    setupBindings()
  }
  
  func setupBindings() {
    segmentCountry.rx.selectedSegmentIndex
      .bind(to: viewModel.countrySigment)
      .disposed(by: disposeBag)
    
    viewModel.cellModels
      .drive(tableView.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { index, model, cell in
        cell.viewModel = model
      }.disposed(by: disposeBag)
  }

}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

