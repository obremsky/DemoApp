//
//  JMFactList.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/20/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMFactList: Decodable{
  var title : String?
  var facts : [JMFact]?
  
  enum CodingKeys : String, CodingKey {
    case title
    case facts = "rows"
  }
}
