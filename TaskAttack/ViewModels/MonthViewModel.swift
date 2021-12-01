//
//  MonthViewModel.swift
//  TaskAttack
//
//  Created by Jacob Odle on 10/30/21.
//

import Foundation
import Combine
import SwiftUI

class MonthViewModel: ObservableObject {
    @Environment(\.calendar) var calendar;
    @Published var currentDate: Date = Date();
    @Published var viewDate: Date = Date();
    
    
  
    // This actually sets the interval, you can change this to show more or less.
    public var month: DateInterval {
        calendar.dateInterval(of: .month, for: viewDate)!
    }
    
    public func adjustMonth(number: Int) {
        var changeMonth = DateComponents();
        changeMonth.day = 0;
        changeMonth.month = number;
        changeMonth.year = 0;
        viewDate = Calendar.current.date(byAdding: changeMonth, to: viewDate)!
    }

    
    func todayDate(date: Date) -> Bool {
        if (date.get(.month) == currentDate.get(.month) && date.get(.day) == currentDate.get(.day))  && date.get(.year) == currentDate.get(.year){
            return true;
        }
        return false;
    }
    
}

