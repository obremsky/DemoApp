//
//  JMFactCell.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import RxSwift

class JMFactCell: BaseCollectionCell {
  
  @IBOutlet weak var imageView: UIImageView!
  var disposeBag = DisposeBag()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func configure(with viewModel: CellModel) {
    guard let viewModel = viewModel as? JMFactCellModel else {
      return
    }
    
    print("\(viewModel) is set to cell")
    viewModel.image.asObservable().observeOn(MainScheduler.instance).subscribe(onNext : {[weak self] image in
      self?.imageView.image = image
    }).disposed(by: disposeBag)
    
    if viewModel.image.value == nil{
      print("\(viewModel) image is nil. Will fetch")
      viewModel.fetch()
    }else {
      print("\(viewModel) image is NOT nil. Wont fetch")
    }
  }
  
  override func prepareForReuse() {
    self.disposeBag = DisposeBag()
    super.prepareForReuse()
  }
}
