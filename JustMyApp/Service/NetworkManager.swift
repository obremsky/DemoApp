//
//  NetworkManager.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/20/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
  static let shared = NetworkManager()
  
  lazy var session : URLSession = {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    return session
  }()
}
