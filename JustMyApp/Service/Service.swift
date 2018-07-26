//
//  Service.swift
//  Rize
//
//  Created by Ludovic Galabru on 13/01/2017.
//  Copyright © 2017 YouNow. All rights reserved.
//

import Foundation

class Service: NSObject {
  let backgroundQueue = DispatchQueue(label: "io.rize.services", attributes: .concurrent)
}
