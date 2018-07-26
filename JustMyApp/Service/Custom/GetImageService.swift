//
//  GetImageService.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import PromiseKit

enum GetImageServiceError: Error{
  case couldntReadImageFromDisc
}

class GetImageService: ClientAPIService {
  
  var url : String
  var fileUrl : String
  
  init(url : String, fileUrl : String) {
    self.url = url
    self.fileUrl = fileUrl
  }
  
  func execute() -> Promise<UIImage> {
    return Promise <UIImage> {seal in
      firstly{
        return self.downloadFile(url: self.url, fileUrl: self.fileUrl)
        }.done({ (fileUrl) in
          
        
          let path = JMPathBuilder.defaultCachePath() + "/" + URL(string: fileUrl)!.lastPathComponent
          let data = FileManager.default.contents(atPath: path)!
          guard let image = UIImage.init(data: data) else {
            
            //If we have donwloaded image, but it's "broken"
            defer {
              seal.reject(GetImageServiceError.couldntReadImageFromDisc)
            }
            
            do {
              let filePath = JMPathBuilder.defaultFullCachePath() + "/" + URL(string: fileUrl)!.lastPathComponent
              try FileManager.default.removeItem(at: URL(string: filePath)!)
            }catch{
              print("Can't delete wrong image")
            }
            return
          }
          seal.fulfill(image)
        }).catch({ (error) in
          seal.reject(error)
        })
    }
  }
}
