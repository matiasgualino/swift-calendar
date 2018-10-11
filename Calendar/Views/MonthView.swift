//
//  MonthView.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarProtocol {
    func onSelectedDate(_ date: Date)
}

class MonthView: UIStackView {
    
    private var month: Int
    private var year: Int
    private var holidays: [Int] = [Int]()
    
    private var dateFormatter: DateFormatter? = nil
    
    private var weekViews = [WeekStackView]()
    var delegate: CalendarProtocol? = nil
    
    private var weekHeight = CGFloat(0)
    
    let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
    
    init(month: Int, year: Int, holidays: [String] = [String](), holidaysFormat: String = "yyyy-MM-dd") {
        self.month = month
        self.year = year
        super.init(frame: CGRect.zero)
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter!.dateFormat = holidaysFormat
        self.holidays = holidays.compactMap({ self.getDayIfInMonth(dateString: $0) })
        
        self.prepareView()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func prepareView() {
        self.backgroundColor = UIColor.white
        self.axis = UILayoutConstraintAxis.vertical
        self.distribution = UIStackViewDistribution.fillEqually
        self.alignment = UIStackViewAlignment.fill
        self.spacing = 8.0
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.isUserInteractionEnabled = true
    }
    
    func layoutView() {
        self.layoutIfNeeded()
        
        self.weekHeight = (self.bounds.width - (6 * WeekStackView.SPACING)) / 7
        
        var components = DateComponents()
        components.day = 1
        components.month = self.month
        components.year = self.year
        
        if let date = self.calendar.date(from: components),
            let monthRange = self.calendar.range(of: .day, in: .month, for: date) {
            let weekdayComponent = self.calendar.dateComponents([Calendar.Component.weekday], from: date)
            if let weekday = weekdayComponent.weekday,
                let startDay = Weekdays(rawValue: weekday) {
                var to = 7 - weekday + 1 // weekday starts in 1.
                
                self.addTitle(forDate: date)
                
                let weekdaysStackView = WeekdaysStackView()
                weekdaysStackView.heightAnchor.constraint(equalToConstant: self.weekHeight).isActive = true
                self.addArrangedSubview(weekdaysStackView)
                
                self.addWeekStackView(startDay: startDay, from: 1, to: to)
                
                let numDays = monthRange.count
                var days = numDays - to
                while days > 0 {
                    let newTo = to + 7
                    self.addWeekStackView(from: to + 1, to: min(newTo, numDays))
                    
                    to = newTo
                    days = days - 7
                }
            }
        }
    }
    
    fileprivate func addTitle(forDate: Date) {
        let calendarTitleLabel = UILabel()
        calendarTitleLabel.heightAnchor.constraint(equalToConstant: self.weekHeight).isActive = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        calendarTitleLabel.text = dateFormatter.string(from: forDate)
        calendarTitleLabel.textColor = UIColor.blue
        calendarTitleLabel.textAlignment = .center
        calendarTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addArrangedSubview(calendarTitleLabel)
    }
    
    fileprivate func addWeekStackView(startDay: Weekdays = Weekdays.SUNDAY, from: Int, to: Int) {
        let week = WeekStackView(startDay: startDay, from: from, to: to, holidays: holidays)
        week.heightAnchor.constraint(equalToConstant: self.weekHeight).isActive = true
        week.onSelectedDay = self.onSelectedDay
        self.weekViews.append(week)
        self.addArrangedSubview(week)
    }
    
    fileprivate func getDayIfInMonth(dateString: String) -> Int? {
        if let dateFormatter = self.dateFormatter, let date = dateFormatter.date(from: dateString) {
            let dateComponents = self.calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: date)
            if let month = dateComponents.month, month == self.month,
                let year = dateComponents.year, year == self.year {
                return dateComponents.day
            }
        }
        return nil
    }
    
    private func onSelectedDay(day: Int) {
        var components = DateComponents()
        components.day = day
        components.month = self.month
        components.year = self.year
        if let date = self.calendar.date(from: components) {
            self.weekViews.forEach({
                if $0.from <= day && day <= $0.to {
                    $0.selectedDay = day
                } else {
                    $0.selectedDay = nil
                }
            })
            
            self.delegate?.onSelectedDate(date)
        }
    }
    
}
