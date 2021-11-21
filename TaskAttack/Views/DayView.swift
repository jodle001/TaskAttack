//
//  DayView.swift.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/4/21.
//

import SwiftUI

struct DayView: View {
    
    let day: Date
    
    var body: some View {
        VStack {
            Text("\(WeekDay.allCases[day.get(.weekday)-1].rawValue) \(MonthName.allCases[day.get(.month)-1].rawValue) \(day.get(.day))th")
                .font(.title)
                .underline()
                .foregroundColor(Color("DayIconNumber"))
            Spacer()
            EventListView(date: day)
            }
        }
    }

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: Date())
    }
}

enum WeekDay: String, CaseIterable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

enum MonthName: String, CaseIterable {
    case January
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
}
