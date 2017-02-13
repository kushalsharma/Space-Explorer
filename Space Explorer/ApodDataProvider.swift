//
//  ApodDataProvider.swift
//  Wallmax
//
//  Created by Kushal Sharma on 18/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import RealmSwift
import Realm

class ApodDataProvider {
    let apodListener: ApodDataListener
    
    init(apodListener: ApodDataListener) {
        self.apodListener = apodListener
    }
    
    func getPictureForDate(date: String){
        let realm = try! Realm()
        if let photoDataFromDate = realm.objects(ApodData.self).filter("date = '\(date)'").first {
            print("Getting data from database for \(date)")
            self.apodListener.onComplete(data: photoDataFromDate)
        } else {
            print("Making date request from network for \(date)")
            let urlFromDate: String = "https://api.nasa.gov/planetary/apod?date=\(date)&api_key=am2bGuOTJGJcwfqpkpUbw6nfObcu9S4G5MiXcc7A"
            Alamofire.request(urlFromDate).responseJSON { response in
                if let jsonData = response.result.value {
                    var photoDataFromDateUrl: ApodData = ApodData()
                    do { try photoDataFromDateUrl = ApodData(jsonValue: jsonData as! [String : Any]) }
                    catch {
                        DispatchQueue.main.async {
                            self.apodListener.onError()
                        }
                    }
                    if photoDataFromDateUrl.title != "" {
                    try! realm.write {
                        realm.add(photoDataFromDateUrl)
                        print("Writing to database for \(date)")
                        DispatchQueue.main.async {
                                self.apodListener.onComplete(data: photoDataFromDateUrl)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.apodListener.onError()
                    }
                }
            }
        }
    }
    
    func getAllApodList() -> [ApodData] {
        var allApodList = [ApodData]()
        let realm = try! Realm()
        let dataList: Results = realm.objects(ApodData.self)
        for item in dataList {
            allApodList.append(item)
        }
        return allApodList
    }
    
    func clearHistory() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

protocol ApodDataListener {
    func onComplete(data: ApodData)
    
    func onError()
}
