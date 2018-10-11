//
//  ViewController.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let holidays = ["2020-02-02", "2020-02-18", "2020-02-21", "2020-02-29"]
        
        let weekdaysStackView = WeekdaysStackView()
        let calendarView = CalendarView(month: 2, year: 2020, holidays: holidays)
        [weekdaysStackView, calendarView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            weekdaysStackView.heightAnchor.constraint(equalToConstant: 44),
            weekdaysStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            weekdaysStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            weekdaysStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: weekdaysStackView.bottomAnchor, constant: 8),
            ])
        
        weekdaysStackView.backgroundColor = UIColor.white
        weekdaysStackView.itemTextColor = UIColor.black
        
        calendarView.layoutView()
    }

}

