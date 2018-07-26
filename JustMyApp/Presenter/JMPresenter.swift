//
//  JMPresenter.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMPresenter: NSObject {
  
  class func viewController(with identifier : String, storyboard : String = "Main") -> UIViewController?{
    let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: identifier)
    return vc
  }
  
}
