//
//  Widget.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 10/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

protocol Widget {
    associatedtype VH
    associatedtype VM
    
    func createViewHolder() -> VH
    
    func bindViewHolder(viewHolder: VH, viewModel: VM)
}
