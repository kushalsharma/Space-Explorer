//
//  ViewController.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 10/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit
import DatePickerDialog

class FeaturedController: UIViewController, ApodDataListener {
    @IBOutlet weak var containerView: UIView!

    let constraintManager = ConstraintManager()
    var apodDataProvider: ApodDataProvider? = nil
    
    let headerWidget = HeaderWidget()
    let imageWidget = ImageWidget()
    let descriptionWidget = DescriptionWidget()
    
    var headerViewHolder: HeaderViewHolder? = nil
    var imageViewHolder: ImageViewHolder? = nil
    var descriptionViewHolder: DescriptionViewHolder? = nil
    
    var headerViewModel: HeaderViewModel? = HeaderViewModel()
    var imageViewModel: ImageViewModel? = ImageViewModel()
    var descriptionViewModel: DescriptionViewModel? = DescriptionViewModel()
    
    var selectedDate: String = ""
    var fromHistoryController: Bool = false
    var calendar = Calendar.current
    var currentDate: Date = Date()
    var minDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-d"
        minDate = dateFormatter.date(from: "1995-10-01")!
        
        headerViewHolder = headerWidget.createViewHolder()
        headerWidget.bindViewHolder(viewHolder: headerViewHolder!, viewModel: headerViewModel!)
        
        imageViewHolder = imageWidget.createViewHolder()
        imageWidget.bindViewHolder(viewHolder: imageViewHolder!, viewModel: imageViewModel!)
        
        descriptionViewHolder = descriptionWidget.createViewHolder()
        descriptionWidget.bindViewHolder(viewHolder: descriptionViewHolder!, viewModel: descriptionViewModel!)
        
        containerView.addSubview((headerViewHolder?.view)!)
        containerView.addSubview((imageViewHolder?.view)!)
        containerView.addSubview((descriptionViewHolder?.view)!)
        
        addConstraints(enable: true)
        
        apodDataProvider = ApodDataProvider.init(apodListener: self)
        
        currentDate = calendar.date(byAdding: .day, value: -1, to: Date())!
        self.apodDataProvider?.getPictureForDate(date: dateFormatter.string(from: currentDate))
    }
    
    @IBAction func pickDateClicked(_ sender: UIBarButtonItem) {
        DatePickerDialog().show(title: "Pick date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: currentDate, minimumDate: minDate, maximumDate: calendar.date(byAdding: .day, value: -1, to: Date()), datePickerMode: .date) {
            (date) -> Void in
            if date != nil {
                self.currentDate = date!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-d"
                self.apodDataProvider?.getPictureForDate(date: dateFormatter.string(from: date!))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromHistoryController && selectedDate != "" {
            fromHistoryController = false
            apodDataProvider?.getPictureForDate(date: selectedDate)
        }
    }
    
    func addConstraints(enable: Bool) {
        constraintManager.widthMatchParent(parent: containerView, child: (headerViewHolder?.view)!, enable: enable)
        constraintManager.widthMatchParent(parent: containerView, child: (imageViewHolder?.view)!, enable: enable)
        constraintManager.widthMatchParent(parent: containerView, child: (descriptionViewHolder?.view)!, enable: enable)
        
        constraintManager.position(view: (headerViewHolder?.view)!, topOfParent: containerView, enable: enable)
        constraintManager.position(view: (imageViewHolder?.view)!, below: (headerViewHolder?.view)!, enable: enable)
        constraintManager.position(view: (descriptionViewHolder?.view)!, below: (imageViewHolder?.view)!, enable: enable)
        constraintManager.position(view: (descriptionViewHolder?.view)!, bottomOfParent: containerView, enable: enable)
    }
    
    internal func onComplete(data: ApodData) {
        headerViewModel?.titleText = data.title
        headerViewModel?.dateText = data.date
        imageViewModel?.imageUrl = data.url
        descriptionViewModel?.description = data.explanation
        
        headerWidget.bindViewHolder(viewHolder: headerViewHolder!, viewModel: headerViewModel!)
        imageWidget.bindViewHolder(viewHolder: imageViewHolder!, viewModel: imageViewModel!)
        descriptionWidget.bindViewHolder(viewHolder: descriptionViewHolder!, viewModel: descriptionViewModel!)
    }
    
    func onError() {
        showAlert(title: "Error", message: "Something went wrong!", actionTitle: "Okay")
    }
    
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: ["https://apod.nasa.gov/apod/astropix.html"], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
        })
        present(alert, animated: true, completion: nil)
    }
    
    func getLoadingAlert() -> UIViewController {
        let alert = UIAlertController(title: nil, message: "Loading data ...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50,height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        return alert
    }
}
