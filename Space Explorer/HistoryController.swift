//
//  HistoryController.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 12/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class HistoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ApodDataListener, UICollectionViewDelegateFlowLayout {
    var width: CGFloat = 0
    var apodHistoryList = [ApodData]()
    var apodDataProvider: ApodDataProvider? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        width = UIScreen.main.bounds.size.width
        
        apodDataProvider = ApodDataProvider.init(apodListener: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadListData()
    }
    
    let reuseIdentifier = "ApodCollectionCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apodHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! HistoryCell
        cell.titleLabel.text = apodHistoryList[indexPath.item].title
        cell.dateLabel.text = apodHistoryList[indexPath.item].date
        cell.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.tabBarController?.viewControllers?[0].childViewControllers[0] as? FeaturedController {
            vc.selectedDate = apodHistoryList[indexPath.item].date
            vc.fromHistoryController = true
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: 64)
    }
    
    func onComplete(data: ApodData) {
    }
    
    func onError() {
    }
    
    func reloadListData() {
        apodHistoryList.removeAll()
        apodHistoryList = (apodDataProvider?.getAllApodList())!
        collectionView.reloadData()
    }
    
    @IBAction func clearHistoryClicked(_ sender: UIBarButtonItem) {
        apodDataProvider?.clearHistory()
        reloadListData()
    }
}
