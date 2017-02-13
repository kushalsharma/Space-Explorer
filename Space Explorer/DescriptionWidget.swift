//
//  DescriptionWidget.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 11/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class DescriptionWidget: Widget {
    
    func createViewHolder() -> DescriptionViewHolder {
        let descriptionViewHolder = DescriptionViewHolder()
        descriptionViewHolder.view = UINib(nibName: "DescriptionWidget", bundle: nil).instantiate(withOwner: descriptionViewHolder, options: nil)[0] as! UIView
        return descriptionViewHolder
    }
    
    func bindViewHolder(viewHolder: DescriptionViewHolder, viewModel: DescriptionViewModel) {
        viewHolder.descriptionLabel.text = viewModel.description
    }
}

class DescriptionViewHolder: NSObject, ViewHolder {
    @IBOutlet weak var descriptionLabel: UILabel!
    internal var view: UIView!
}

struct DescriptionViewModel: ViewModel {
    var description: String = ""
}
