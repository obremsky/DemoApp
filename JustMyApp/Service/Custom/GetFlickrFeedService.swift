//
//  GetFlickrFeedService.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import PromiseKit

enum FlickrFeedError : Error{
  case formatError
}

class GetFlickrFeedService: ClientAPIService {
  
  let page : Int
  init(page : Int) {
    self.page = page
  }
  
  func execute() -> Promise<JMFlickrFeed>{
    
    return  Promise<JMFlickrFeed>{seal in
      
      let url = JMUrlBuilder.shared.flickrUrl(with : "flickr.people.getPublicPhotos")
      firstly{
        return self.sendGETRequest(at: url, withHeaders: nil)
        }.done({ (data) in
          do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let json = json as? [String : Any]{
              print(json)
            }
            
            guard let feed = try? JSONDecoder().decode(JMFlickrFeed.self, from: data) else {
              seal.reject(FlickrFeedError.formatError)
              return
            }
            seal.fulfill(feed)
          }
          
        }).catch({ (error) in
          seal.reject(error)
        })
    }
  }
}
