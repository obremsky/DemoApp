//
//  JMFlickrFeedVC.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

class JMFlickrFeedVC: UIViewController {
  
  let viewModel : FlickrFeedViewModel = FlickrFeedViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchNext()
  }
}
