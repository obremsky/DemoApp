//
//  FlickrFeedViewModel.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import PromiseKit

class FlickrFeedViewModel: NSObject {
  
  var page : Int = 0
  func fetchNext(){
    firstly{
      return GetFlickrFeedService(page: 0).execute()
      }.done {[weak self] (feed) in
        self?.page += 1
        print(feed)
      }.catch {[weak self] (error) in
        print(error)
        self?.page += 0
      }
  }
}
