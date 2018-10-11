//
//  Weekdays.swift
//  Calendar
//
//  Created by Matias Gualino on 10/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

enum Weekdays: Int {
    case SUNDAY = 1,
    MONDAY = 2,
    THURSDAY = 3,
    WEDNESDAY = 4,
    TUESDAY = 5,
    FRIDAY = 6,
    SATURDAY = 7;
    
    static var ALL = [SUNDAY, MONDAY, THURSDAY, WEDNESDAY, TUESDAY, FRIDAY, SATURDAY]
    
    var shortName : String {
        get {
            switch self {
            case .SUNDAY:
                return "Sun"
            case .MONDAY:
                return "Mon"
            case .THURSDAY:
                return "Thu"
            case .WEDNESDAY:
                return "Wed"
            case .TUESDAY:
                return "Tue"
            case .FRIDAY:
                return "Fri"
            case .SATURDAY:
                return "Sat"
            }
        }
    }
}
