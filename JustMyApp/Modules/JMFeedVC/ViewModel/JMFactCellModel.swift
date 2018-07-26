//
//  JMFactCellModel.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import RxSwift
import PromiseKit

class JMFactCellModel: CellModel {
  
  var disposeBag = DisposeBag()
  var model : JMFact
  var image : Variable<UIImage?> = Variable(nil)
  var isLoading : Bool = false
  
  var shouldLoad : Bool = true

  
  var title : String? {
    return self.model.title
  }
  
  var factDescription: String?{
    return self.model.factDescription
  }
  
  init (model : JMFact){
    self.model = model
    super.init()
    
    self.image.asObservable().subscribe(onNext: {[weak self] (image) in
      if let _  = image{
        print("\(self!) loaded image")
      }else {
        print("\(self!) did reset image")
      }
    }).disposed(by: disposeBag)
  }
  
  func fetch(){
    if self.isLoading == true{
      return
    }
    
//    if self.shouldLoad == false{
//      print("something wrong with model. shouldn't load")
//      return
//    }
    
    if let url = self.model.imageUrl{
      self.isLoading = true
      let fileUrl = JMPathBuilder.defaultFullCachePath() + "/" + URL(string: url)!.lastPathComponent.replacingOccurrences(of: " ", with: "%20")
      firstly{
        return GetImageService(url : url, fileUrl : fileUrl).execute()
        }.done {[weak self] (image) in
          self?.image.value = image
        }.catch {[weak self] (error) in
          print("ERROR : \(error)")
          self?.shouldLoad = false
        }.finally {[weak self] in
          self?.isLoading = false
      }
    }else {
      print("No image url!!!!")
    }
  }
}
