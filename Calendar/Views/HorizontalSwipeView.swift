//
//  HorizontalSwipeView.swift
//  Calendar
//
//  Created by Matias Gualino on 11/10/18.
//  Copyright © 2018 Brubank. All rights reserved.
//

import Foundation
import UIKit

class HorizontalSwipeView : UIScrollView {
    
    var currentIndex: Int = 0
    var items: [MonthView] = [MonthView]()
    
    func layoutView() {
        self.isUserInteractionEnabled = true
        
        // In case of this view be inside of cell.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.addGestureRecognizer(swipeLeft)
        
        self.loadItems()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            var index = self.currentIndex
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if index > 0 {
                    index -= 1
                }
            case UISwipeGestureRecognizerDirection.left:
                if index < items.count-1 {
                    index += 1
                }
            default:
                break
            }
            self.setItem(index: index)
        }
    }
    
    func setItem(index: Int) {
        if index >= 0 && index <= items.count-1 {
            self.currentIndex = index
            self.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(self.currentIndex), y: self.contentOffset.y), animated: true)
        }
    }
    
    func loadItems() {
        var prevItem: MonthView? = nil
        for item in self.items {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
            
            NSLayoutConstraint.activate([
                item.widthAnchor.constraint(equalTo: self.widthAnchor),
                item.leadingAnchor.constraint(equalTo: prevItem == nil ? self.leadingAnchor : prevItem!.trailingAnchor),
                item.heightAnchor.constraint(equalTo: self.heightAnchor),
                item.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
            
            item.layoutView()
            prevItem = item
        }
    }
}
