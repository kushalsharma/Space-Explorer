//
//  ImageWidget.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 11/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import AlamofireImage

class ImageWidget: Widget {
    
    func createViewHolder() -> ImageViewHolder {
        let imageViewHolder = ImageViewHolder()
        imageViewHolder.view = UINib(nibName: "ImageWidget", bundle: nil).instantiate(withOwner: imageViewHolder, options: nil)[0] as! UIView
        return imageViewHolder
    }
    
    func bindViewHolder(viewHolder: ImageViewHolder, viewModel: ImageViewModel) {
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: viewHolder.imageView.frame.size,
            radius: 2.0
        )
        if (viewModel.imageUrl != ""){
            let url = viewModel.imageUrl
            viewHolder.imageView.image = nil
            viewHolder.progressCircle.startAnimating()
            viewModel.imageUrl.insert("s", at: url.index(url.startIndex, offsetBy: 4))
            viewHolder.imageView.af_setImage(withURL: URL(string: (viewModel.imageUrl))!, filter: filter, completion: { response in viewHolder.progressCircle.stopAnimating()})
        }
    }
}

class ImageViewHolder: NSObject, ViewHolder {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressCircle: UIActivityIndicatorView!
    internal var view: UIView!
}

class ImageViewModel: Object, ViewModel {
    var imageUrl: String = ""
}
