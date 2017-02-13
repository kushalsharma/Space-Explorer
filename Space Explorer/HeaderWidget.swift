//
//  HeaderWidget.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 11/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class HeaderWidget: NSObject, Widget {

    func createViewHolder() -> HeaderViewHolder {
        let headerViewHolder = HeaderViewHolder()
        headerViewHolder.view = UINib(nibName: "HeaderWidget", bundle: nil).instantiate(withOwner: headerViewHolder, options: nil)[0] as! UIView
        return headerViewHolder
    }
    
    func bindViewHolder(viewHolder: HeaderViewHolder, viewModel: HeaderViewModel) {
        viewHolder.titleLabel.text = viewModel.titleText
        viewHolder.dateLabel.text = viewModel.dateText
    }
}

class HeaderViewHolder: NSObject, ViewHolder {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    internal var view: UIView!
}

class HeaderViewModel: ViewModel {
    var titleText: String = ""
    var dateText: String = ""
}
