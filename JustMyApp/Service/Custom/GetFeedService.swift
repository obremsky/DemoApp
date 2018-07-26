//
//  GetFeedService.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/19/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import PromiseKit

enum GetFeedError : Error{
  case formatError
}

class GetFeedService: ClientAPIService {
  
  var url : String
  var fileUrl : String

  init (url : String, fileUrl : String){
    self.url = url
    self.fileUrl = fileUrl
  }
  
  func execute() -> Promise<JMFactList>{
    return Promise<JMFactList> {seal in
      firstly{
        return self.downloadFile(url : self.url, fileUrl: self.fileUrl)
        }.done({ (filePath) in
          do{
            let data = try Data(contentsOf: URL(string: filePath)!)
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let usefulData = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
              print("could not convert data to UTF-8 format")
              seal.reject(GetFeedError.formatError)
              return
            }
            
            let json = try JSONSerialization.jsonObject(with: usefulData, options: [])
            if let json = json as? [String : Any]{
                  print(json)
            }
            guard let feed = try? JSONDecoder().decode(JMFactList.self, from: usefulData) else {
              seal.reject(GetFeedError.formatError)
              return
            }
            seal.fulfill(feed)
          } catch{
            print("Error while parsing JSON")
            seal.reject(GetFeedError.formatError)
          }
        }).catch({ (error) in
          seal.reject(error)
        })
    }
  }
}
