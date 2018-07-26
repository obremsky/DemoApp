//
//  JMFeedsVC.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/24/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit

enum Feed : Int{
  case simple
  case flickr
}

class JMFeedsVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var models : [Feed] = [Feed]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configureUI()
  }
  
  func setup(){
    var index = 0
    var done : Bool = false
    repeat {
      if let item = Feed.init(rawValue: index){
        self.models.append(item)
        index += 1
      }else {
        done = true
      }
    }while !done
  }
  
  func configureUI(){
    configureTableView()
  }
  
  func configureTableView(){
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    self.tableView.tableFooterView = UIView()
  }
}

extension JMFeedsVC : UITableViewDataSource, UITableViewDelegate{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let model = self.models[indexPath.row]
    cell.textLabel?.text = "\(model)"
    
//    switch indexPath.row {
//    case 0:
//      cell.textLabel?.text = "Simple feed"
//    case 1:
//      cell.textLabel?.text = "Flickr feed"
//    default:
//      break
//    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var vc : UIViewController? = nil
    switch indexPath.row {
    case 0:
      vc = JMPresenter.viewController(with: "JMFeedVC")
    case 1:
      vc = JMPresenter.viewController(with: "JMFlickrFeedVC")
    default:
      break
    }
    
    if let vc = vc {
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}
