//
//  SelectableLabel.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

protocol Selectable {
    func onSelected(id: String)
}

class SelectableLabel: UILabel {
    
    var id: String
    var delegate: Selectable?
    
    var selectedBackgroundColor: UIColor = UIColor.blue
    var unselectedBackgroundColor: UIColor = UIColor.clear
    var selectedTextColor: UIColor = UIColor.white
    var unselectedTextColor: UIColor = UIColor.black
    
    var disableTextColor: UIColor = UIColor.lightGray
    var enableTextColor: UIColor = UIColor.black
    
    override var isEnabled: Bool {
        didSet {
            self.textColor = self.isEnabled ? self.enableTextColor : self.disableTextColor
            self.isUserInteractionEnabled = self.isEnabled
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            self.backgroundColor = self.isSelected ? self.selectedBackgroundColor : self.unselectedBackgroundColor
            self.textColor = self.isSelected ? self.selectedTextColor : self.unselectedTextColor
            self.layer.cornerRadius = self.isSelected ? self.frame.size.height*0.5 : 0
        }
    }
    
    init(id: String) {
        self.id = id
        super.init(frame: CGRect.zero)
        
        self.accessibilityLabel = id
        self.clipsToBounds = true
        self.isUserInteractionEnabled = self.isEnabled
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    @objc private func tapped() {
        self.isSelected = !self.isSelected
        self.delegate?.onSelected(id: self.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
