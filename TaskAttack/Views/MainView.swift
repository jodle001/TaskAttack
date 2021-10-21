//
//  MainView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 10/14/21.
//
import SwiftUI

struct MainView: View {
  @Environment(\.calendar) var calendar
    var currentDate: Date = Date();
  
    // This actually sets the interval, you can change this to show more or less.
  private var year: DateInterval {
      calendar.dateInterval(of: .month, for: currentDate)!
  }
  
  var body: some View {
      VStack {
          // Main calendar view that shows a month.
          // TODO: should be able to select dates at somepoint to show a day view of that day.
          CalendarView(interval: year) { date in
              Text(String(self.calendar.component(.day, from: date)))
                .frame(width: 35, height: 35, alignment: .center)
                .background(date.get(.day) == currentDate.get(.day) ? Color(.blue) : Color("DayIcons") )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical, 3)
                .foregroundColor(Color("DayIconNumber"))
          }
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
    
