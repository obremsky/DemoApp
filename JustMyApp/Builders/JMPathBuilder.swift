//
//  JMPathBuilder.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMPathBuilder: NSObject {
  
  class func defaultCachePath() -> String{
    let docDirURL = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
    let fileURL = docDirURL.appendingPathComponent("jmcache/").relativePath
    return fileURL
  }
  
  class func defaultFullCachePath() -> String{
    let docDirURL = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
    let fileURL = docDirURL.appendingPathComponent("jmcache/").absoluteString
    return fileURL
  }
}
