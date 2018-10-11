//
//  LabelsStackView.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

class LabelsStackView: UIStackView {
    
    static let SPACING = CGFloat(8.0)
    
    var itemLabels = [UILabel]()
    
    var itemTextColor: UIColor = UIColor.black {
        didSet {
            self.itemLabels.forEach({ $0.textColor = itemTextColor })
        }
    }
    
    var itemFont: UIFont = UIFont.boldSystemFont(ofSize: 14) {
        didSet {
            self.itemLabels.forEach({ $0.font = itemFont })
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.prepareView()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func prepareView() {
        self.backgroundColor = UIColor.white
        self.axis = UILayoutConstraintAxis.horizontal
        self.distribution = UIStackViewDistribution.fillEqually
        self.alignment = UIStackViewAlignment.fill
        self.spacing = LabelsStackView.SPACING
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.layoutViews()
    }
    
    func addLabel(_ label: UILabel) {
        self.itemLabels.append(label)
        self.addArrangedSubview(label)
    }
    
    func layoutViews() { }
}
