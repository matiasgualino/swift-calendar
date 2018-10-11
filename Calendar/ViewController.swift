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
        
        let calendarView = CalendarView(fromMonth: 8, fromYear: 2018, toMonth: 3, toYear: 2020, holidays: holidays)
        let selectedDateLabel = UILabel()
        [calendarView, selectedDateLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            selectedDateLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20),
            selectedDateLabel.heightAnchor.constraint(equalToConstant: 44),
            selectedDateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            selectedDateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        
        calendarView.calendarDelegate = self
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
        self.selectedDateLabel.text = dateFormatter.string(from: date)
    }
}

