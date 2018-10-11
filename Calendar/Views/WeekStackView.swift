//
//  WeekStackView.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

class WeekStackView: LabelsStackView {
    
    var selectedTextColor: UIColor = UIColor.white
    var unselectedTextColor: UIColor = UIColor.black
    var selectedBackgroundColor: UIColor = UIColor.blue
    var unselectedBackgroundColor: UIColor = UIColor.clear
    var disableTextColor: UIColor = UIColor.gray
    var enableTextColor: UIColor = UIColor.white
    
    private var startDay: Weekdays
    var from: Int
    var to: Int
    private var holidays = [Int]()
    
    var onSelectedDay: ((Int) -> Void)? = nil
    
    var selectedDay: Int? = nil {
        didSet {
            self.itemLabels.forEach({
                if let label = $0 as? SelectableLabel, let day = Int(label.id) {
                    label.isSelected = day == selectedDay
                }
            })
        }
    }
    
    init(startDay: Weekdays = Weekdays.SUNDAY, from: Int, to: Int, holidays: [Int]) {
        self.startDay = startDay
        self.from = from
        self.to = to
        self.holidays = holidays
        super.init()
        
        self.isUserInteractionEnabled = true
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutViews() {
        if self.startDay != Weekdays.SUNDAY {
            for _ in stride(from: 1, to: self.startDay.rawValue, by: 1) {
                self.addUnusedLabel()
            }
        }
        
        let to = 7 - self.startDay.rawValue + 1
        let lightFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        
        for i in stride(from: 0, to: to, by: 1) {
            let currentDay = self.from + i
            
            if currentDay <= self.to {
                let dayLabel = SelectableLabel(id: "\(currentDay)")
                dayLabel.delegate = self
                dayLabel.text = "\(currentDay)"
                dayLabel.textColor = self.itemTextColor
                dayLabel.font = lightFont
                dayLabel.textAlignment = .center
                dayLabel.isEnabled = !self.holidays.contains(currentDay)
                dayLabel.selectedFont = boldFont
                dayLabel.unselectedFont = lightFont
                dayLabel.selectedTextColor = self.selectedTextColor
                dayLabel.unselectedTextColor = self.unselectedTextColor
                dayLabel.unselectedBackgroundColor = self.unselectedBackgroundColor
                dayLabel.selectedBackgroundColor = self.selectedBackgroundColor
                dayLabel.enableTextColor = self.enableTextColor
                dayLabel.disableTextColor = self.disableTextColor
                self.addLabel(dayLabel)
            } else {
                self.addUnusedLabel()
            }
        }
    }
    
    private func addUnusedLabel() {
        let dayLabel = SelectableLabel(id: "")
        dayLabel.isEnabled = false
        dayLabel.text = ""
        self.addLabel(dayLabel)
    }
}

extension WeekStackView: Selectable {
    func onSelected(id: String) {
        if let day = Int(id) {
            self.onSelectedDay?(day)
        }
    }
}
