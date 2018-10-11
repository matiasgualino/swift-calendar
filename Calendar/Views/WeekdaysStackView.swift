//
//  WeekdaysStackView.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

class WeekdaysStackView: LabelsStackView {
    override func layoutViews() {
        Weekdays.ALL.map({ (weekday) -> UILabel in
            let dayLabel = UILabel()
            dayLabel.font = self.itemFont
            dayLabel.textColor = self.itemTextColor
            dayLabel.text = weekday.shortName
            dayLabel.textAlignment = .center
            return dayLabel
        }).forEach({
            self.addLabel($0)
        })
    }
}
