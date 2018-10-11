//
//  CalendarView.swift
//  Calendar
//
//  Created by Matias Gualino on 11/10/18.
//  Copyright © 2018 Brubank. All rights reserved.
//

import Foundation
import UIKit

class CalendarView: HorizontalSwipeView {
    
    var fromMonth: Int
    var fromYear: Int
    var toMonth: Int
    var toYear: Int
    var holidays: [String]
    
    var calendarDelegate: CalendarProtocol? = nil
    
    init(fromMonth: Int, fromYear: Int, toMonth: Int, toYear: Int, holidays: [String] = [String]()) {
        self.fromMonth = fromMonth
        self.fromYear = fromYear
        self.toMonth = toMonth
        self.toYear = toYear
        self.holidays = holidays
        
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutView() {
        self.items = getMonthViews()
        super.layoutView()
    }
    
    private func getMonthViews() -> [MonthView] {
        var monthViews = [MonthView]()
        for year in stride(from: self.fromYear, to: self.toYear + 1, by: 1) {
            var fromMonth = 1
            var toMonth = 12
            if year == self.fromYear {
                fromMonth = self.fromMonth
                toMonth = 12
            } else if year == self.toYear {
                fromMonth = 1
                toMonth = self.toMonth
            }
            
            for month in stride(from: fromMonth, to: toMonth + 1, by: 1) {
                let monthView = MonthView(month: month, year: year, holidays: self.holidays)
                monthView.delegate = self
                monthViews.append(monthView)
            }
        }
        return monthViews
    }
}

extension CalendarView: CalendarProtocol {
    func onSelectedDate(_ date: Date) {
        self.calendarDelegate?.onSelectedDate(date)
    }
}
