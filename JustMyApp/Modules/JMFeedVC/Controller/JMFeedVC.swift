//
//  JMFeedVC.swift
//  JustMyApp
//
//  Created by Viacheslav Obremsky on 7/23/18.
//  Copyright © 2018 Viacheslav Obremsky. All rights reserved.
//

import UIKit
import RxSwift

class JMFeedVC: UIViewController {
  
  let disposeBag = DisposeBag()
  @IBOutlet weak var collectionView: UICollectionView!
  let viewModel : JMFeedViewModel =  JMFeedViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureUI()
    configureSubscriptions()
    self.viewModel.fetch()
  }
  
  func configureUI(){
    
    let reloadButton = UIBarButtonItem.init(title: "Reload", style: .done, target: self, action: #selector(JMFeedVC.reload(_:)))
    self.navigationItem.rightBarButtonItem = reloadButton
    
    
    let layout = UICollectionViewFlowLayout()
    collectionView.collectionViewLayout = layout
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(UINib.init(nibName: "JMFactCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
  }
  
  func configureSubscriptions(){
    self.viewModel.models.asObservable().observeOn(MainScheduler.instance).subscribe(onNext : {[weak self] models in
      self?.collectionView.reloadData()
    }).disposed(by: disposeBag)
    
    self.viewModel.isLoading.asObservable().subscribe(onNext : {loading in
      
    }).disposed(by: disposeBag)
  }
  
  @objc func reload(_ sender : UIBarButtonItem){
    self.collectionView.scrollRectToVisible(.zero, animated: false)
    JMFileManager.shared.cleanCacheIfNeeds()
    self.viewModel.fetch()
  }
}

extension JMFeedVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.models.value.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! JMFactCell
    let cellModel = self.viewModel.models.value[indexPath.row]
    cell.configure(with: cellModel)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width, height: 200)
  }
}
