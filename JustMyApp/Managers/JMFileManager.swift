//
//  JMFileManager.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMFileManager: NSObject {

  static let shared = JMFileManager()
  
  func cleanCacheIfNeeds(){
    let path = JMPathBuilder.defaultCachePath()
    var isDir : ObjCBool = true
    if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) == true{
      do {
        let items = try FileManager.default.contentsOfDirectory(atPath: path)
        try items.forEach { (itemPath) in
          try FileManager.default.removeItem(atPath: path + "/" + itemPath)
        }
      }catch {
        print("Error cleaning cache")
      }
    }else {
      do {
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: [:])
      }catch{
        print("Error while creating cache folder : \(error)")
      }
    }
  }
}
