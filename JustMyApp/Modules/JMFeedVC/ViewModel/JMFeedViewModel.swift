//
//  JMFeedViewModel.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import RxSwift
import PromiseKit

class JMFeedViewModel {
  var models : Variable <[JMFactCellModel]> = Variable([JMFactCellModel]())
  var isLoading : Variable <Bool> = Variable(false)

  func fetch(){
    let url = JMUrlBuilder.shared.simpleFactsUrl
    let fileUrl = JMPathBuilder.defaultFullCachePath() + "/feed.json"
  
    firstly {
      return GetFeedService(url : url, fileUrl : fileUrl).execute()
      }.done {[weak self] model in
        if let facts = model.facts {
          self?.models.value = facts.map({ (model) -> JMFactCellModel in
            return JMFactCellModel(model: model)
          })
        }
      }.catch { (error) in
        print (error)
      }.finally {
        print("Finished")
    }
  }
}
