//
//  JMFact.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/20/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMFact: Decodable {
  var title : String?
  var factDescription : String?
  var imageUrl : String?
  
  enum CodingKeys : String, CodingKey {
    case title
    case factDescription = "description"
    case imageUrl = "imageHref"
  }
}
