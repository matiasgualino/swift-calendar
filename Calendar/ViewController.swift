//
//  ViewController.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var selectedDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let holidays = ["2020-02-02", "2020-02-18", "2020-02-21", "2020-02-29"]
        let month = 2
        let year = 2020
        
        let calendarTitleLabel = UILabel()
        let weekdaysStackView = WeekdaysStackView()
        let calendarView = CalendarView(month: month, year: year, holidays: holidays)
        let selectedDateLabel = UILabel()
        [calendarTitleLabel, weekdaysStackView, calendarView, selectedDateLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            calendarTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            calendarTitleLabel.heightAnchor.constraint(equalToConstant: 44),
            calendarTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            weekdaysStackView.heightAnchor.constraint(equalToConstant: 44),
            weekdaysStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            weekdaysStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            weekdaysStackView.topAnchor.constraint(equalTo: calendarTitleLabel.bottomAnchor, constant: 10),
            
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: weekdaysStackView.bottomAnchor, constant: 8),
            
            selectedDateLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20),
            selectedDateLabel.heightAnchor.constraint(equalToConstant: 44),
            selectedDateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            selectedDateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        var components = DateComponents()
        components.day = 1
        components.month = month
        components.year = year
        if let date = calendar.date(from: components) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            calendarTitleLabel.text = dateFormatter.string(from: date)
        }
        calendarTitleLabel.textColor = UIColor.blue
        calendarTitleLabel.textAlignment = .center
        calendarTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        weekdaysStackView.backgroundColor = UIColor.white
        weekdaysStackView.itemTextColor = UIColor.black
        
        calendarView.delegate = self
        calendarView.layoutView()
        
        selectedDateLabel.textColor = UIColor.black
        selectedDateLabel.textAlignment = .center
        selectedDateLabel.font = UIFont.systemFont(ofSize: 16)
        self.selectedDateLabel = selectedDateLabel
    }

}

extension ViewController: CalendarProtocol {
    func onSelectedDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDateLabel.text = dateFormatter.string(from: date)
    }
}

