//
//  ConstraintManager.swift
//  Space Explorer
//
//  Created by Kushal Sharma on 11/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class ConstraintManager {
    func widthMatchParent(parent: UIView, child: UIView, enable: Bool) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1.0, constant: 0).isActive = enable
        NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: NSLayoutAttribute.trailingMargin, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func alignParentLeft(parent: UIView, child: UIView, enable: Bool) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func alignParentRight(parent: UIView, child: UIView, enable: Bool) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: child, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: NSLayoutAttribute.trailingMargin, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func position(view: UIView, below: UIView, enable: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: below, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func position(view: UIView, toRightOf: UIView, enable: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: toRightOf, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func position(view: UIView, topOfParent: UIView, enable: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topOfParent, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0).isActive = enable
    }
    
    func position(view: UIView, bottomOfParent: UIView, enable: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: bottomOfParent, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0).isActive = enable
    }
}
