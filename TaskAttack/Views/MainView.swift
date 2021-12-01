//
//  MainView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 10/14/21.
//
import SwiftUI

struct MainView: View {
    var body: some View {
      VStack {
          // Main calendar view that shows a month.
          // TODO: should be able to select dates at somepoint to show a day view of that day.
          MainMonthView()
          // This is the list view we have made that has basic features.
          // TODO: Move the signin to the top of the MainView instead of inside the TaskView
          TaskListView()
      }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
    

struct MainMonthView: View {
    var monthModel = MonthViewModel();
    
    var body: some View {
        CalendarView() { date in
            Text(String(monthModel.calendar.component(.day, from: date)))
                .frame(width: 35, height: 35, alignment: .center)
                .background(monthModel.todayDate(date: date) ? Color(.blue) : Color("DayIcons"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical, 3)
                .foregroundColor(Color("DayIconNumber"))
        }
    }
    
}
